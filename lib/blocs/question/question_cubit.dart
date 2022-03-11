import 'package:bloc/bloc.dart';

import '../../models/models.dart';
import '../../api/api.dart';
import '../../repository/repositories.dart';

class QuestionCubit extends Cubit<ApiResponse> {
  QuestionCubit() : super(ApiResponse.loading("loading"));

  Future<void> fetch() async {
    final QuestionRepository _repository = QuestionRepository();
    try {
      final List<QuestionModel> data = await _repository.request(name: "");
      emit(ApiResponse.completed(data));
    } catch (e) {
      emit(ApiResponse.error("$e"));
    }
  }
}