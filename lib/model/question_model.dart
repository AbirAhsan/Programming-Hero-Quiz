class QuestionModel {
  String? question;
  Map? answers;
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
    answers = json['answers'];
    questionImageUrl = json['questionImageUrl'].toString();
    correctAnswer = json['correctAnswer'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers!;
    }
    data['questionImageUrl'] = questionImageUrl;
    data['correctAnswer'] = correctAnswer;
    data['score'] = score;
    return data;
  }
}
