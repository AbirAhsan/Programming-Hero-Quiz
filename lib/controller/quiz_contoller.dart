import 'package:get/get.dart';

import '../model/question_model.dart';
import '../services/api_service/quiz_api_service.dart';

class QuizController extends GetxController {
  //<=================================== Quiz All Question List
  RxList<QuestionModel?> allQuestionList =
      List<QuestionModel?>.empty(growable: true).obs;

  @override
  void onInit() {
    fetchAllQuestionList();
    super.onInit();
  }

//
//<<======================================== Fetch All Question And Assign To List
  Future<void> fetchAllQuestionList() async {
    try {
      QuizApiService().getQuestionList().then((resp) {
        allQuestionList.value = resp.toList();
      }, onError: (err) {
        print(err);
      });
    } catch (e) {
      print(e);
    }
    update();
  }
}
