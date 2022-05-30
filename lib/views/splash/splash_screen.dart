import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quiz/views/variables/color_variables.dart';
import 'package:quiz/views/variables/icon_variables.dart';

import '../../controller/screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController screenCtrl = Get.put(ScreenController());
    screenCtrl.splasDelay();
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Image.asset(
              CustomIcons.logo!,
            ),
          ],
        ),
      ),
    );
  }
}
