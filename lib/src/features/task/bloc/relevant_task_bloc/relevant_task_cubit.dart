import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'relevant_task_state.dart';

mixin OpenTaskCubit on RemoteDataCubit<Task> {}
mixin ClosedTaskCubit on RemoteDataCubit<Task> {}

class RelevantTaskCubit extends RemoteDataCubit<Task> with OpenTaskCubit, ClosedTaskCubit {
  final TaskRepository _repository;

  RelevantTaskCubit(this._repository);

  @override
  Future<PageData<Task>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page, query);
  }
}
