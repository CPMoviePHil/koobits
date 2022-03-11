import '../../api/api.dart';
import '../../models/models.dart';

class QuestionRepository  {

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<QuestionModel>> request ({
    required String name
  }) async {
    final response = await _helper.get(urlName: name,) as List;
    return response.map((e) => QuestionModel.fromJson(e)).toList();
  }
}

