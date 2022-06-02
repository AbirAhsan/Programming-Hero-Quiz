import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/views/main_screen/home_screen.dart';
import 'package:quiz/views/variables/color_variables.dart';
import 'package:quiz/views/variables/custom_image_widget.dart';
import 'package:quiz/views/variables/icon_variables.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

import '../controller/quiz_contoller.dart';
import '../views/widgets/custom_elevated_button.dart';
import 'page_navigation_service.dart';

class ResultDialogService {
  static final QuizController quizCtrl = Get.put(QuizController());

  static showResult() {
    quizCtrl.getHighestScore().then((_) {
      return Get.defaultDialog(
          barrierDismissible: false,
          title: quizCtrl.highestScore.value > quizCtrl.currentScore.value ||
                  quizCtrl.currentScore.value == 0
              ? "Sorry"
              : "Congrats",
          titleStyle: CustomTextStyles.titleGreenBoldStyle,
          content: Column(
            children: [
              CustomImageWidget(
                imagepath:
                    quizCtrl.highestScore.value > quizCtrl.currentScore.value ||
                            quizCtrl.currentScore.value == 0
                        ? CustomIcons.sad
                        : CustomIcons.congrats,
                size: 80,
              ),
              Text(
                "You just scored ${quizCtrl.currentScore}.",
                style: CustomTextStyles.smallBlackRegularStyle,
              ),
              Text(
                quizCtrl.highestScore.value > quizCtrl.currentScore.value ||
                        quizCtrl.currentScore.value == 0
                    ? "But You can't reach to Highest Score"
                    : "You set a new highest score",
                style: CustomTextStyles.smallBlackRegularStyle,
              ),
              Text(
                "Previous Highest Score : ${quizCtrl.highestScore.value}",
                style: CustomTextStyles.normalBlackBoldStyle,
              ),
            ],
          ),
          confirm: CustomElevatedButton(
              buttonName: "Back To Home",
              fontSize: 16,
              onPressed: () {
                if (!(quizCtrl.highestScore.value >
                        quizCtrl.currentScore.value ||
                    quizCtrl.currentScore.value == 0)) {
                  quizCtrl.setHighestScore(quizCtrl.currentScore.value);
                }

                PageNavigationService.removeAllAndNavigate(const HomeScreen());
              }));
    });
  }
}
