import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

import '../bloc.dart';

part 'task_stage_chain_state.dart';

class TaskStageChainCubit extends RemoteDataCubit<TaskStage> with ReactiveTasks {
  final TaskStageChainRepository _taskStageChainRepository;

  TaskStageChainCubit(this._taskStageChainRepository);

  @override
  Future<PageData<TaskStage>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _taskStageChainRepository.fetchDataOnPage(page, query);
  }

  @override
  Future<void> createTask(TaskStage task) async {
    try {
      final createdTaskId = await _taskStageChainRepository.createTask(task.id);
      print('>>> createdTaskId = $createdTaskId');
      emit(TaskChainCreated.clone(state as RemoteDataLoaded<TaskStage>, createdTaskId));
    } catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(TaskChainCreatingError.clone(state as RemoteDataLoaded<TaskStage>, e.toString()));
    }
  }

}