import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'previous_task_event.dart';

part 'previous_task_state.dart';

class PreviousTaskBloc extends Bloc<PreviousTaskEvent, PreviousTaskState> {
  final int taskId;
  final TaskDetailRepository _repository;

  PreviousTaskBloc({
    required TaskDetailRepository repository,
    required this.taskId,
  })  : _repository = repository,
        super(PreviousTaskUninitialized()) {
    on<FetchPreviousTask>(_onFetchPreviousTask);
    add(FetchPreviousTask());
  }

  Future<void> _onFetchPreviousTask(
    FetchPreviousTask event,
    Emitter<PreviousTaskState> emit,
  ) async {
    emit(PreviousTaskFetching());
    try {
      final data = await _repository.fetchPreviousTaskData(taskId);
      emit(PreviousTaskLoaded(data));
    } catch (e) {
      print(e);
      emit(PreviousTaskFetchingError(e.toString()));
    }
  }
}
