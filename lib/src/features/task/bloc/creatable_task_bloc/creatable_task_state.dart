part of 'creatable_task_bloc.dart';

abstract class CreatableTaskState extends RemoteDataType {
  @override
  List<Object> get props => [];
}

class CreatableTaskUninitialized extends CreatableTaskState {}

class CreatableTaskFetching extends CreatableTaskState with RemoteDataFetching {}

class CreatableTaskFetchingError extends CreatableTaskState with RemoteDataError {
  final String error;

  CreatableTaskFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class CreatableTaskInitialized extends CreatableTaskState {
  final List<TaskStage> data;
  final int currentPage;
  final int total;

  CreatableTaskInitialized({
    required this.data,
    required this.currentPage,
    required this.total,
  });

  CreatableTaskInitialized.clone(CreatableTaskInitialized state)
      : this(data: state.data, currentPage: state.currentPage, total: state.total);

  @override
  List<Object> get props => [data, currentPage, total];
}

class CreatableTaskLoaded extends CreatableTaskInitialized with RemoteDataSuccess {
  CreatableTaskLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
  });
}

class CreatableTaskRefetching extends CreatableTaskInitialized with RemoteDataFetching {
  CreatableTaskRefetching({
    required super.data,
    required super.currentPage,
    required super.total,
  });

  CreatableTaskRefetching.clone(CreatableTaskInitialized state) : super.clone(state);
}

class CreatableTaskRefetchingError extends CreatableTaskInitialized with RemoteDataError {
  final String error;

  CreatableTaskRefetchingError({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  CreatableTaskRefetchingError.clone(CreatableTaskInitialized state, this.error)
      : super.clone(state);

  @override
  List<Object> get props => [...super.props, error];
}

class TaskCreating extends CreatableTaskInitialized {
  final int createdTaskId;

  TaskCreating({
    required this.createdTaskId,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  TaskCreating.clone(CreatableTaskInitialized state, this.createdTaskId) : super.clone(state);
}

class TaskCreatingError extends CreatableTaskInitialized {
  final String error;

  TaskCreatingError({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  TaskCreatingError.clone(
    CreatableTaskInitialized state,
    this.error,
  ) : super.clone(state);
}
