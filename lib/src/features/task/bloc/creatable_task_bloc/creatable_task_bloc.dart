import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'creatable_task_event.dart';
part 'creatable_task_state.dart';

class CreatableTaskBloc extends Bloc<CreatableTaskEvent, CreatableTaskState> {
  final CreatableTaskRepository _repository;

  CreatableTaskBloc(this._repository) : super(CreatableTaskUninitialized()) {
    on<FetchCreatableTaskData>(_onFetchCreatableTaskData);
    on<RefetchCreatableTaskData>(_onRefetchCreatableTaskData);
    on<CreateTask>(_onCreateTask);
    add(const FetchCreatableTaskData(0));
  }

  Future<void> _onFetchCreatableTaskData(
    FetchCreatableTaskData event,
    Emitter<CreatableTaskState> emit,
  ) async {
    final page = event.page;
    try {
      emit(CreatableTaskFetching());

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(CreatableTaskLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(CreatableTaskFetchingError(e.toString()));
      emit(state);
    }
  }

  Future<void> _onRefetchCreatableTaskData(
    RefetchCreatableTaskData event,
    Emitter<CreatableTaskState> emit,
  ) async {
    final page = event.page;
    try {
      emit(CreatableTaskRefetching.clone(state as CreatableTaskLoaded));

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(CreatableTaskLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(CreatableTaskRefetchingError.clone(state as CreatableTaskLoaded, e.toString()));
      emit(state);
    }
  }

  Future<void> _onCreateTask(CreateTask event, Emitter<CreatableTaskState> emit) async {
    try {
      final task = event.task;
      final createdTaskId = await _repository.createTask(task.id);
      emit(TaskCreating.clone(state as CreatableTaskInitialized, createdTaskId));
    } catch (e) {
      print(e);
      emit(TaskCreatingError.clone(state as CreatableTaskLoaded, e.toString()));
    }
  }
}
