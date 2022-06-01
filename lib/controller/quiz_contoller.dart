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
      if (currentScore.value > highestScore.value) {
        setHighestScore(currentScore.value);
      }
    }

    update();
    gotoNextQuestion();
  }

  //
  //<<================================ Next Question Functionality
  Future<void> gotoNextQuestion() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (currentQuestionIndex.value + 1 == allQuestionList.length) {
        PageNavigationService.removeAllAndNavigate(const HomeScreen());
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

  getHighestScore() async {
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
