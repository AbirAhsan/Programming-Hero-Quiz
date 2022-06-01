import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/views/main_screen/quiz_screen/answer_card.dart';
import 'package:quiz/views/variables/color_variables.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

import '../../../controller/quiz_contoller.dart';
import 'question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final QuizController quizCtrl = Get.put(QuizController());
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: const Text(
            "QUIZ",
            style: CustomTextStyles.titleWhiteBoldStyle,
          ),
          bottom: PreferredSize(
            preferredSize: Size(width, 20),
            child: Obx(
              () => LinearPercentIndicator(
                padding: const EdgeInsets.all(0.0),
                animation: true,
                width: width,
                restartAnimation: false,
                animateFromLastPercent: true,
                lineHeight: 20.0,
                percent: quizCtrl.progress.value,
                center: Text(
                  "${quizCtrl.progress.value * 100}% Complete",
                  style: CustomTextStyles.smallWhiteBoldStyle,
                ),
                backgroundColor: CustomColors.grey,
                progressColor: CustomColors.green,
              ),
            ),
          )),
      body: ListView(
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
                        .length,
                    itemBuilder: (buildContext, index) {
                      Answers answer = quizCtrl
                          .allQuestionList[quizCtrl.currentQuestionIndex.value]!
                          .answers![index];

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
    );
  }
}
