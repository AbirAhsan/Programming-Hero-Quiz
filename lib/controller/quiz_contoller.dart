import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/services/custom_eassy_loading.dart';
import 'package:quiz/services/page_navigation_service.dart';
import 'package:quiz/views/main_screen/home_screen.dart';

import '../model/answer_model.dart';
import '../model/question_model.dart';
import '../services/api_error_handle_service.dart';
import '../services/api_service/quiz_api_service.dart';

class QuizController extends GetxController {
  RxInt currentQuestionIndex = 0.obs;
  //<============================== Current Score
  RxInt currentScore = 0.obs;

  //<<============================= Is Answer Select
  RxBool isAnswerSelect = false.obs;
  //<=================================== Quiz All Question List
  RxList<QuestionModel?> allQuestionList =
      List<QuestionModel?>.empty(growable: true).obs;

  @override
  void onInit() {
    fetchAllQuestionList();

    super.onInit();
  }

//<====================================== Selected Answer
  RxList<AnswerModel?> selectedAnswerList =
      List<AnswerModel?>.empty(growable: true).obs;

//
//<<======================================== Fetch All Question And Assign To List
  Future<void> fetchAllQuestionList() async {
    try {
      CustomEassyLoading.startLoading();
      QuizApiService().getQuestionList().then((resp) {
        allQuestionList.value = resp.toList();
        CustomEassyLoading.stopLoading();
      }, onError: (err) {
        print(err);
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint(e.toString());
      CustomEassyLoading.stopLoading();
    } catch (e) {
      print(e);
      CustomEassyLoading.stopLoading();
    }
    update();
  }

  //<============================== Select Answer Function
  selectAnswer(AnswerModel? selectedAnswer) {
    isAnswerSelect.value = false;
    selectedAnswerList.clear();
    selectedAnswerList.add(selectedAnswer);
    isAnswerSelect.value = true;
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
        PageNavigationService.removeAllAndNavigate(const HomeScreen());
      } else {
        isAnswerSelect.value = false;
        selectedAnswerList.clear();
        currentQuestionIndex.value++;
      }
    });
    update();
  }
}
