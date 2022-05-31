import 'dart:async';
import 'package:get_storage/get_storage.dart';

class SharedDataManageService {
  static final box = GetStorage();

//<=========================================== Highest Score Saved Functionality
  static Future<void> setHighestScore(int highestScore) async {
    box.write('highestScore', highestScore);
  }

  static Future<int> getHighestScore() async {
    int highestScore = box.read(
          "highestScore",
        ) ??
        0;
    return highestScore;
  }

  static Future<void> removeHighestScore() async {
    box.remove('highestScore');
  }
}
