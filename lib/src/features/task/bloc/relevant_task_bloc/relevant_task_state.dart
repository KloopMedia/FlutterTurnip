part of 'relevant_task_bloc.dart';

mixin RemoteDataFetching on RelevantTaskState {}

mixin RemoteDataSuccess on RelevantTaskState {}

mixin RemoteDataError on RelevantTaskState {}

abstract class RelevantTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class RelevantTaskUninitialized extends RelevantTaskState {}

class RelevantTaskFetching extends RelevantTaskState with RemoteDataFetching {}

class RelevantTaskFetchingError extends RelevantTaskState with RemoteDataError {
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

  RelevantTaskInitialized.clone(RelevantTaskInitialized state)
      : this(data: state.data, currentPage: state.currentPage, total: state.total);

  @override
  List<Object> get props => [data, currentPage, total];
}

class RelevantTaskLoaded extends RelevantTaskInitialized with RemoteDataSuccess {
  RelevantTaskLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
  });
}

class RelevantTaskRefetching extends RelevantTaskInitialized with RemoteDataFetching {
  RelevantTaskRefetching({
    required super.data,
    required super.currentPage,
    required super.total,
  });

  RelevantTaskRefetching.clone(RelevantTaskInitialized state) : super.clone(state);
}

class RelevantTaskRefetchingError extends RelevantTaskInitialized with RemoteDataError {
  final String error;

  RelevantTaskRefetchingError({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  RelevantTaskRefetchingError.clone(RelevantTaskInitialized state, this.error) : super.clone(state);

  @override
  List<Object> get props => [...super.props, error];
}
