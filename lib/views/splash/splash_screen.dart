import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/screen_controller.dart';
import '../variables/icon_variables.dart';

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
