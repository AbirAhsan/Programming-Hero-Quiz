class QuestionModel {
  String? question;
  List<Answers>? answers;
  String? questionImageUrl;
  String? correctAnswer;
  int? score;

  QuestionModel(
      {this.question,
      this.answers,
      this.questionImageUrl,
      this.correctAnswer,
      this.score});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answers'] != null) {
      answers =
          json['answers'] != null ? convertMapToList(json['answers']) : [];
    }
    questionImageUrl = json['questionImageUrl'];
    correctAnswer = json['correctAnswer'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['questionImageUrl'] = questionImageUrl;
    data['correctAnswer'] = correctAnswer;
    data['score'] = score;
    return data;
  }
}

class Answers {
  String? option;
  String? value;

  Answers({this.option, this.value});

  Answers.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    data['value'] = value;
    return data;
  }
}

List<Answers> convertMapToList(Map answers) {
  List<Answers> list = answers.entries
      .map((entry) => Answers(option: entry.key, value: entry.value))
      .toList();

  return list;
}
