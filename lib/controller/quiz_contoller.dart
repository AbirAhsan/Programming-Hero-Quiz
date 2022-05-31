import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/services/custom_eassy_loading.dart';

import '../model/question_model.dart';
import '../services/api_error_handle_service.dart';
import '../services/api_service/quiz_api_service.dart';

class QuizController extends GetxController {
  RxInt currentQuestionIndex = 0.obs;
  //<=================================== Quiz All Question List
  RxList<QuestionModel?> allQuestionList =
      List<QuestionModel?>.empty(growable: true).obs;

  @override
  void onInit() {
    fetchAllQuestionList();

    super.onInit();
  }

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
}
