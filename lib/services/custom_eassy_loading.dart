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
        CustomIcons.logo2!,
        width: 100,
        height: 130,
      ),
    );
  }

//<<================ Stop Loading Function
  static stopLoading() async {
    await EasyLoading.dismiss();
  }
}
