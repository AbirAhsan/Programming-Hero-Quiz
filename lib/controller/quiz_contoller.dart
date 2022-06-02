import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/controller/screen_controller.dart';

import '../model/question_model.dart';
import '../services/api_error_handle_service.dart';
import '../services/api_service/quiz_api_service.dart';
import '../services/custom_eassy_loading.dart';
import '../services/page_navigation_service.dart';
import '../services/shared_data.dart';
import '../views/main_screen/home_screen.dart';
import '../views/variables/icon_variables.dart';
import '../views/variables/teststyle_variable.dart';
import '../views/widgets/custom_elevated_button.dart';
import '../views/widgets/custom_image_widget.dart';

class QuizController extends GetxController {
  RxInt currentQuestionIndex = 0.obs;
  //<============================== Highest Score
  RxInt highestScore = 0.obs;
  //<============================== Current Score
  RxInt currentScore = 0.obs;
//<<============================== Question Progress ANimation Value
  RxDouble progress = 0.0.obs;
  //<<============================= Is Answer Select
  RxBool isAnswerSelect = false.obs;

  //<<================================== Timer Time
  RxInt time = 10.obs;
  //<=================================== Quiz All Question List
  RxList<QuestionModel?> allQuestionList =
      List<QuestionModel?>.empty(growable: true).obs;

  @override
  void onInit() {
    getHighestScore();

    super.onInit();
  }

//<====================================== Selected Answer
  RxList<Answers?> selectedAnswerList =
      List<Answers?>.empty(growable: true).obs;

//
//<<======================================== Fetch All Question And Assign To List
  Future<void> fetchAllQuestionList() async {
    try {
      CustomEassyLoading.startLoading();
      QuizApiService().getQuestionList().then((resp) {
        currentScore.value = 0;
        progress.value = 0.0;
        isAnswerSelect.value = false;
        allQuestionList.value = resp.toList();
        CustomEassyLoading.stopLoading();
        currentQuestionIndex.value = 0;

        countDownTimer();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint(e.toString());
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint(e.toString());
    }
    update();
  }

  //<============================== Select Answer Function
  selectAnswer(Answers? selectedAnswer) {
    isAnswerSelect.value = false;
    selectedAnswerList.clear();
    selectedAnswerList.add(selectedAnswer);
    isAnswerSelect.value = true;
    progress.value += 1 / allQuestionList.length;
    if (selectedAnswer!.option ==
        allQuestionList[currentQuestionIndex.value]!.correctAnswer) {
      currentScore.value += allQuestionList[currentQuestionIndex.value]!.score!;
    }

    update();
    gotoNextQuestion();
  }

  //
  //<<================================ Next Question Functionality
  Future<void> gotoNextQuestion() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (currentQuestionIndex.value + 1 == allQuestionList.length) {
        Get.defaultDialog(
            barrierDismissible: false,
            title: highestScore.value > currentScore.value ||
                    currentScore.value == 0
                ? "Sorry"
                : "Congrats",
            titleStyle: CustomTextStyles.titleGreenBoldStyle,
            content: Obx(
              () => Column(
                children: [
                  CustomImageWidget(
                    imagepath: highestScore.value > currentScore.value ||
                            currentScore.value == 0
                        ? CustomIcons.sad
                        : CustomIcons.congrats,
                    size: 80,
                  ),
                  Text(
                    "You just scored ${currentScore.value}.",
                    style: CustomTextStyles.smallBlackRegularStyle,
                  ),
                  Text(
                    highestScore.value > currentScore.value ||
                            currentScore.value == 0
                        ? "But You can't reach to Highest Score"
                        : "You set a new highest score",
                    style: CustomTextStyles.smallBlackRegularStyle,
                  ),
                  Text(
                    "Previous Highest Score : ${highestScore.value}",
                    style: CustomTextStyles.normalBlackBoldStyle,
                  ),
                ],
              ),
            ),
            confirm: CustomElevatedButton(
                buttonName: "Back To Home",
                fontSize: 16,
                onPressed: () {
                  if (!(highestScore.value > currentScore.value ||
                      currentScore.value == 0)) {
                    setHighestScore(currentScore.value);
                  }

                  PageNavigationService.removeAllAndNavigate(
                      const HomeScreen());
                }));
      } else {
        isAnswerSelect.value = false;
        selectedAnswerList.clear();
        currentQuestionIndex.value++;
        //<<============= And Timer Will Auto Start
        countDownTimer();
      }
    });
    update();
  }

  Future getHighestScore() async {
    highestScore.value = await SharedDataManageService.getHighestScore();
  }

  setHighestScore(int value) {
    SharedDataManageService.setHighestScore(value);
  }

  //<================================ Question Timer
  countDownTimer() async {
    time.value = 10;
    for (int x = time.value; x > 0; x--) {
      await Future.delayed(const Duration(seconds: 1)).then((_) {
        time.value -= 1;
      });

      if (isAnswerSelect.value ||
          Get.put(ScreenController().isBackground.value)) {
        break;
      }
    }

    if (!isAnswerSelect.value) {
      //<<<============= After 10 Seconds (If User isn't select Answer)
      //Answer  Selection Automatically off
      //and show the right answer
      isAnswerSelect.value = true;

      //<<========= Progress Bar Update
      progress.value += 1 / allQuestionList.length;

      //<============================= After That it's go to next question
      // or Home screen as per condition
      gotoNextQuestion();
    }
  }
}
