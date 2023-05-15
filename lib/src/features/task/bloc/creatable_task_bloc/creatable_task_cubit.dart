import 'package:flutter/foundation.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'creatable_task_state.dart';

mixin ReactiveTasks on RemoteDataCubit<TaskStage> {
  Future<void> createTask(TaskStage task);
}
mixin ProactiveTasks on RemoteDataCubit<TaskStage> {
  Future<void> createTask(TaskStage task);
}

class CreatableTaskCubit extends RemoteDataCubit<TaskStage> with ReactiveTasks, ProactiveTasks {
  final CreatableTaskRepository _repository;

  CreatableTaskCubit(this._repository);

  @override
  Future<void> createTask(TaskStage task) async {
    try {
      final createdTaskId = await _repository.createTask(task.id);
      emit(TaskCreated.clone(state as RemoteDataLoaded<TaskStage>, createdTaskId));
    } catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(TaskCreatingError.clone(state as RemoteDataLoaded<TaskStage>, e.toString()));
    }
  }

  @override
  Future<PageData<TaskStage>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}
