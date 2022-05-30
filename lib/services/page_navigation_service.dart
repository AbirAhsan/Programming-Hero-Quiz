import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNavigationService {
  static void generalNavigation(Widget nextScreen) {
    Get.to(nextScreen);
  }

  static void removeAndNavigate(Widget nextScreen) {
    Get.off(nextScreen);
  }

  static void removeAllAndNavigate(Widget nextScreen) {
    Get.offAll(nextScreen);
  }

  static void backScreen() {
    Get.back(result: false);
  }
}
