part of 'relevant_task_bloc.dart';

abstract class RelevantTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class RelevantTaskUninitialized extends RelevantTaskState {}

class RelevantTaskFetching extends RelevantTaskState {}

class RelevantTaskFetchingError extends RelevantTaskState {
  final String error;

  RelevantTaskFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class RelevantTaskInitialized extends RelevantTaskState {
  final List<Task> data;
  final int currentPage;
  final int total;

  RelevantTaskInitialized({
    required this.data,
    required this.currentPage,
    required this.total,
  });

  @override
  List<Object> get props => [data];
}

class RelevantTaskLoaded extends RelevantTaskInitialized {
  RelevantTaskLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
  });
}
