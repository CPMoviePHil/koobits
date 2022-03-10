class QuestionModel {
  QuestionModel({
    required this.id,
    required this.question,
    required this.difficulty,
  });
  late final String id;
  late final String question;
  late final int difficulty;

  QuestionModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    question = json['question'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['difficulty'] = difficulty;
    return _data;
  }
}