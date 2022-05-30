import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../views/variables/icon_variables.dart';

class CustomEassyLoading {
  //<=============== Start Loading Function
  static startLoading() async {
    await EasyLoading.show(
      dismissOnTap: false,
      status: "Please Wait",
      indicator: Image.asset(
        CustomIcons.logo!,
        width: 100,
        height: 130,
      ),
    );
  }

  static startWithProgress(int value) async {
    await EasyLoading.showProgress(
      value / 100, maskType: EasyLoadingMaskType.none,
      status: "$value%\nPlease Wait",
      // indicator: Image.asset(
      //   loader,
      //   width: 100,
      //   height: 130,
      // ),
    );
  }

//<<================ Stop Loading Function
  static stopLoading() async {
    await EasyLoading.dismiss();
  }

  //<===================== Show Success
  static showSuccess(String? meessage) async {
    await EasyLoading.showSuccess(
      "$meessage",
      duration: const Duration(seconds: 2),
      dismissOnTap: true,
    );
  }
}
