import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../app_config.dart';
import '../../model/question_model.dart';

class QuizApiService {
  //<======================================= Get DashBoard List Dynamicly
  Future<List<QuestionModel?>> getQuestionList() async {
    Uri url = Uri.parse("${AppConfig.rawBaseUrl}/quiz.json");

    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    debugPrint("${response.statusCode} $url");
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      Map decoded = json.decode(jsonResponse);

      List<QuestionModel?> mapdatalist = decoded["questions"]
          .map<QuestionModel?>((b) => QuestionModel.fromJson(b))
          .toList();

      return mapdatalist;
    } else {
      var jsonResponse = response.body;
      Map decoded = json.decode(jsonResponse);
      throw decoded;
    }
  }
}
