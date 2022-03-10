class AnswerModel {
  AnswerModel({
    required this.id,
    required this.answer,
  });
  late final String id;
  late final String answer;

  AnswerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['answer'] = answer;
    return _data;
  }
}