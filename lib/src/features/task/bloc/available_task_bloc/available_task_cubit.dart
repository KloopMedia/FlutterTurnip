import 'package:flutter/foundation.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'available_task_state.dart';

class AvailableTaskCubit extends RemoteDataCubit<Task> {
  final AvailableTaskRepository _repository;

  AvailableTaskCubit(this._repository);

  Future<void> requestTaskAssignment(Task task) async {
    try {
      await _repository.requestAssignment(task.id);
      emit(AvailableTaskRequestAssignmentSuccess.clone(state as RemoteDataLoaded<Task>, task));
    } catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(
        AvailableTaskRequestAssignmentFailed.clone(state as RemoteDataLoaded<Task>, e.toString()),
      );
    }
  }

  @override
  Future<PageData<Task>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}
