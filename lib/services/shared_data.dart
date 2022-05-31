import 'dart:async';
import 'package:get_storage/get_storage.dart';

class SharedDataManageService {
  final box = GetStorage();

//<=========================================== Highest Score Saved Functionality
  Future<void> setHighestScore(int highestScore) async {
    box.write('highestScore', highestScore);
  }

  Future<int> getHighestScore() async {
    int highestScore = box.read(
          "highestScore",
        ) ??
        0;
    return highestScore;
  }

  Future<void> removeHighestScore() async {
    box.remove('highestScore');
  }
}
