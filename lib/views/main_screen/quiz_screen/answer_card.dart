import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

import '../../../controller/quiz_contoller.dart';

class AnswerCard extends StatelessWidget {
  final void Function()? onTap;
  final String? answer;

  const AnswerCard({Key? key, this.onTap, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
      child: GestureDetector(
          onTap: onTap,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                answer!,
                style: CustomTextStyles.normalBlackBoldStyle,
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }
}
