import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../services/page_navigation_service.dart';
import '../views/main_screen/home_screen.dart';

class ScreenController extends GetxController with WidgetsBindingObserver {
  //<<============================ is App in Bacground
  RxBool isBackground = false.obs;
  //
  /*<<========================== Splash Delay Function
  After Delayed, it's navigate to Home Screen Automatically
  */

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isBackground.value = state == AppLifecycleState.paused;
    if (isBackground.value) {
      print("App in Background");
      PageNavigationService.removeAllAndNavigate(const HomeScreen());
      isBackground.value = false;
    }
  }

  void splasDelay() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        PageNavigationService.removeAllAndNavigate(const HomeScreen()));
  }
}
