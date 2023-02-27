import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'available_task_event.dart';

part 'available_task_state.dart';

class AvailableTaskBloc extends Bloc<AvailableTaskEvent, AvailableTaskState> {
  final AvailableTaskRepository _repository;

  AvailableTaskBloc(this._repository) : super(AvailableTaskUninitialized()) {
    on<FetchAvailableTaskData>(_onFetchAvailableTaskData);
    on<RefetchAvailableTaskData>(_onRefetchAvailableTaskData);
    on<RequestAvailableTaskAssignment>(_onRequestAvailableTaskAssignment);
    add(const FetchAvailableTaskData(0));
  }

  Future<void> _onFetchAvailableTaskData(
    FetchAvailableTaskData event,
    Emitter<AvailableTaskState> emit,
  ) async {
    final page = event.page;
    try {
      emit(AvailableTaskFetching());

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(AvailableTaskLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(AvailableTaskFetchingError(e.toString()));
      emit(state);
    }
  }

  Future<void> _onRefetchAvailableTaskData(
    RefetchAvailableTaskData event,
    Emitter<AvailableTaskState> emit,
  ) async {
    final page = event.page;
    try {
      emit(AvailableTaskRefetching.clone(state as AvailableTaskLoaded));

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(AvailableTaskLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(AvailableTaskRefetchingError.clone(state as AvailableTaskLoaded, e.toString()));
      emit(state);
    }
  }

  Future<void> _onRequestAvailableTaskAssignment(
    RequestAvailableTaskAssignment event,
    Emitter<AvailableTaskState> emit,
  ) async {
    final task = event.task;
    emit(AvailableTaskRequestAssignment.clone(state as AvailableTaskLoaded, task));
    try {
      await _repository.requestAssignment(task.id);
      emit(AvailableTaskRequestAssignmentSuccess.clone(state as AvailableTaskLoaded, task));
    } catch (e) {
      print(e);
      emit(
        AvailableTaskRequestAssignmentFailed.clone(
          state as AvailableTaskLoaded,
          e.toString(),
        ),
      );
      emit(state);
    }
  }
}
