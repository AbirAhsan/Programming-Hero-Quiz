import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:quiz/views/variables/color_variables.dart';
import 'package:quiz/views/variables/teststyle_variable.dart';

class ApiErrorHandleService {
  static handleStatusCodeError(Map<String, dynamic> status) {
    Get.showSnackbar(
      GetSnackBar(
        title: status["BucketName"],
        messageText: Text(
          status["Code"],
          style: CustomTextStyles.normalWhiteBoldStyle,
        ),
        backgroundColor: CustomColors.red,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}
