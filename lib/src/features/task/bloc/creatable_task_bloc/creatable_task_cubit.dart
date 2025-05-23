import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'creatable_task_state.dart';

mixin ReactiveTasks on RemoteDataCubit<TaskStage> {
  Future<void> createTask(TaskStage task);

  Future<void> createTaskById(int id);
}
mixin ProactiveTasks on RemoteDataCubit<TaskStage> {
  Future<void> createTask(TaskStage task);

  Future<void> createTaskById(int id);
}
mixin ProactiveTasksButtons on RemoteDataCubit<TaskStage> {
  Future<void> createTask(TaskStage task);

  Future<void> createTaskById(int id);
}

class CreatableTaskCubit extends RemoteDataCubit<TaskStage>
    with ReactiveTasks, ProactiveTasks, ProactiveTasksButtons {
  final CreatableTaskRepository _repository;

  CreatableTaskCubit(this._repository);

  @override
  Future<void> createTask(TaskStage task) async {
    try {
      final createdTaskId = await _repository.createTask(task.id);
      emit(TaskCreated.clone(state as RemoteDataInitialized<TaskStage>, createdTaskId));
      emit(RemoteDataLoaded.clone(state as RemoteDataInitialized<TaskStage>));
    } on DioException catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(TaskCreatingError.clone(state as RemoteDataInitialized<TaskStage>, e));
      emit(RemoteDataLoaded.clone(state as RemoteDataInitialized<TaskStage>));
    }
  }

  @override
  Future<void> createTaskById(int id) async {
    try {
      final createdTaskId = await _repository.createTask(id);
      emit(TaskCreated.clone(state as RemoteDataInitialized<TaskStage>, createdTaskId));
      emit(RemoteDataLoaded.clone(state as RemoteDataInitialized<TaskStage>));
    } on DioException catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(TaskCreatingError.clone(state as RemoteDataInitialized<TaskStage>, e));
      emit(RemoteDataLoaded.clone(state as RemoteDataInitialized<TaskStage>));
    }
  }

  @override
  Future<PageData<TaskStage>> fetchAndParseData(int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) {
    return _repository.fetchDataOnPage(page, query);
  }
}
