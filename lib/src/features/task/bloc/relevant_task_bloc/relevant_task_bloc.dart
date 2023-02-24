import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'relevant_task_event.dart';
part 'relevant_task_state.dart';

mixin OpenTaskBloc on Bloc<RelevantTaskEvent, RelevantTaskState> {}
mixin ClosedTaskBloc on Bloc<RelevantTaskEvent, RelevantTaskState> {}

class RelevantTaskBloc extends Bloc<RelevantTaskEvent, RelevantTaskState>
    with OpenTaskBloc, ClosedTaskBloc {
  final TaskRepository _repository;

  RelevantTaskBloc(this._repository) : super(RelevantTaskUninitialized()) {
    on<FetchRelevantTaskData>(_onFetchRelevantTaskData);
    add(const FetchRelevantTaskData(0));
  }

  Future<void> _onFetchRelevantTaskData(
    FetchRelevantTaskData event,
    Emitter<RelevantTaskState> emit,
  ) async {
    final page = event.page;
    try {
      emit(RelevantTaskFetching());

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(RelevantTaskLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(RelevantTaskFetchingError(e.toString()));
      emit(state);
    }
  }
}
