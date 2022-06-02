import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/quiz_contoller.dart';
import '../../services/page_navigation_service.dart';
import '../variables/color_variables.dart';
import '../variables/icon_variables.dart';
import '../variables/teststyle_variable.dart';
import '../widgets/custom_elevated_button.dart';
import 'quiz_screen/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController quizCtrl = Get.put(QuizController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(15.0),
            children: [
              //<<====================== App Logo Here
              Image.asset(
                CustomIcons.logo!,
              ),
              const Text(
                "Quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: CustomColors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              //<<====================== All Time Highest Score Here
              Obx(
                () => Text(
                  "Highest Scrore \n${quizCtrl.highestScore.value} Point",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleWhiteBoldStyle,
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              //<<===================== New Quiz Game will be start When tap here
              CustomElevatedButton(
                buttonName: "Start",
                onPressed: () => Get.defaultDialog(
                  title: "Attention",
                  content: const Text(
                    "During the Exam, do not try to exit/ change app. If you exit/change to another app then we will dissmiss you from this exam. Then you have to start anew",
                    style: CustomTextStyles.smallBlackRegularStyle,
                  ),
                  confirm: CustomElevatedButton(
                      buttonName: "Continue",
                      fontSize: 16,
                      onPressed: () =>
                          PageNavigationService.removeAllAndNavigate(
                              const QuizScreen())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
