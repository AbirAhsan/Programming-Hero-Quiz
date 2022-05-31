import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

import '../../../controller/quiz_contoller.dart';

class AnswerCard extends StatelessWidget {
  final void Function()? onTap;
  final Answers? answer;
  final String? correctAnswer;

  const AnswerCard({
    Key? key,
    this.onTap,
    this.answer,
    this.correctAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController quizCtrl = Get.put(QuizController());
    return Obx(
      () => Container(
        margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        decoration: BoxDecoration(
          color: quizCtrl.selectedAnswerList.contains(answer) &&
                  answer!.option == correctAnswer
              ? Colors.green
              : quizCtrl.selectedAnswerList.contains(answer) &&
                      answer!.option != correctAnswer
                  ? Colors.red
                  : quizCtrl.isAnswerSelect.value &&
                          answer!.option == correctAnswer
                      ? Colors.green
                      : Colors.transparent,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                answer!.value!,
                style: CustomTextStyles.normalBlackBoldStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
