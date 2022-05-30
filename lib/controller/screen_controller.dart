import 'package:get/get.dart';
import 'package:quiz/services/page_navigation_service.dart';
import 'package:quiz/views/main_screen/home_screen.dart';

class ScreenController extends GetxController {
  //
  /*<<========================== Splash Delay Function
  After Delayed, it's navigate to Home Screen Automatically
  */
  void splasDelay() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        PageNavigationService.removeAllAndNavigate(const HomeScreen()));
  }
}
