class AnswerModel {
  String? option;
  String? value;

  AnswerModel({this.option, this.value});

  AnswerModel.fromJson(Map<String, dynamic> json) {
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
