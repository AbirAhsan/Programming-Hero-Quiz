import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/views/variables/color_variables.dart';
import 'package:quiz/views/variables/icon_variables.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

import '../../../controller/quiz_contoller.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController quizCtrl = Get.put(QuizController());
    return Obx(
      () => quizCtrl.allQuestionList.isNotEmpty &&
              quizCtrl.allQuestionList.length >
                  quizCtrl.currentQuestionIndex.value
          ? Container(
              margin: const EdgeInsets.all(15.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${quizCtrl.allQuestionList[quizCtrl.currentQuestionIndex.value]?.score ?? 0} Point",
                        style: CustomTextStyles.normalBlackBoldStyle,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: CustomColors.grey)),
                        child: Image.network(
                          quizCtrl
                                  .allQuestionList[
                                      quizCtrl.currentQuestionIndex.value]
                                  ?.questionImageUrl ??
                              "",
                          errorBuilder: (context, error, stackTrace) {
                            //do something
                            return const Center(
                                child: Icon(
                              Icons.error,
                              size: 64,
                              color: CustomColors.grey,
                            ));
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                            .toInt()
                                    : null,
                              ),
                            );
                          },
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "${quizCtrl.allQuestionList[quizCtrl.currentQuestionIndex.value]?.question}",
                        style: CustomTextStyles.normalBlackBoldStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
