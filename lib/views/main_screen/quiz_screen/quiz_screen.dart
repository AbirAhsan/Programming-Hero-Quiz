import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/model/answer_model.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/views/main_screen/quiz_screen/answer_card.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

import '../../../controller/quiz_contoller.dart';
import 'question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController quizCtrl = Get.put(QuizController());

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    "Question: ${quizCtrl.currentQuestionIndex.value + 1}/${quizCtrl.allQuestionList.length}",
                    style: CustomTextStyles.normalWhiteBoldStyle,
                  ),
                ),
                Obx(
                  () => Text(
                    "Score : ${quizCtrl.currentScore}",
                    style: CustomTextStyles.normalWhiteBoldStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            //<====================== Question Card is Here

            const QuestionCard(),
            const SizedBox(
              height: 30,
            ),
            //<==================== Answer Cards
            Obx(() {
              return quizCtrl.allQuestionList.isNotEmpty &&
                      quizCtrl.allQuestionList.length >
                          quizCtrl.currentQuestionIndex.value
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: quizCtrl
                          .allQuestionList[quizCtrl.currentQuestionIndex.value]!
                          .answers!
                          .toJson()
                          .entries
                          .map((entry) => AnswerModel(
                              option: entry.key, value: entry.value))
                          .toList()
                          .length,
                      itemBuilder: (buildContext, index) {
                        AnswerModel answer = quizCtrl
                            .allQuestionList[
                                quizCtrl.currentQuestionIndex.value]!
                            .answers!
                            .toJson()
                            .entries
                            .map((entry) => AnswerModel(
                                option: entry.key, value: entry.value))
                            .toList()[index];
                        return AnswerCard(
                          onTap: () {
                            if (!quizCtrl.isAnswerSelect.value) {
                              quizCtrl.selectAnswer(answer);
                            }
                          },
                          answer: answer,
                          correctAnswer: quizCtrl
                              .allQuestionList[
                                  quizCtrl.currentQuestionIndex.value]!
                              .correctAnswer,
                        );
                      })
                  : Container();
            }),
          ],
        ),
      ),
    );
  }
}
