import 'package:flutter/material.dart';
import 'package:quiz/services/page_navigation_service.dart';
import 'package:quiz/views/main_screen/quiz_screen/quiz_screen.dart';
import 'package:quiz/views/variables/color_variables.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';
import 'package:quiz/views/widgets/custom_elevated_button.dart';

import '../variables/icon_variables.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Highest Scrore \n1000 Point",
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleWhiteBoldStyle,
              ),

              const SizedBox(
                height: 40,
              ),
              //<<===================== New Quiz Game will be start When tap here
              CustomElevatedButton(
                  buttonName: "Start",
                  onPressed: () => PageNavigationService.removeAndNavigate(
                      const QuizScreen()))
            ],
          ),
        ),
      ),
    );
  }
}
