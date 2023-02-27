part of 'available_task_bloc.dart';

abstract class AvailableTaskState extends RemoteDataType {
  @override
  List<Object> get props => [];
}

class AvailableTaskUninitialized extends AvailableTaskState {}

class AvailableTaskFetching extends AvailableTaskState with RemoteDataFetching {}

class AvailableTaskFetchingError extends AvailableTaskState with RemoteDataError {
  final String error;

  AvailableTaskFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class AvailableTaskInitialized extends AvailableTaskState {
  final List<Task> data;
  final int currentPage;
  final int total;

  AvailableTaskInitialized({
    required this.data,
    required this.currentPage,
    required this.total,
  });

  AvailableTaskInitialized.clone(AvailableTaskInitialized state)
      : this(data: state.data, currentPage: state.currentPage, total: state.total);

  @override
  List<Object> get props => [data, currentPage, total];
}

class AvailableTaskLoaded extends AvailableTaskInitialized with RemoteDataSuccess {
  AvailableTaskLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
  });
}

class AvailableTaskRefetching extends AvailableTaskInitialized with RemoteDataFetching {
  AvailableTaskRefetching({
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRefetching.clone(AvailableTaskInitialized state) : super.clone(state);
}

class AvailableTaskRefetchingError extends AvailableTaskInitialized with RemoteDataError {
  final String error;

  AvailableTaskRefetchingError({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRefetchingError.clone(AvailableTaskInitialized state, this.error)
      : super.clone(state);

  @override
  List<Object> get props => [...super.props, error];
}

class AvailableTaskRequestAssignment extends AvailableTaskInitialized {
  final Task task;

  AvailableTaskRequestAssignment({
    required this.task,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRequestAssignment.clone(super.state, this.task) : super.clone();
}

class AvailableTaskRequestAssignmentSuccess extends AvailableTaskInitialized {
  final Task task;

  AvailableTaskRequestAssignmentSuccess({
    required this.task,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRequestAssignmentSuccess.clone(super.state, this.task) : super.clone();
}

class AvailableTaskRequestAssignmentFailed extends AvailableTaskInitialized {
  final String error;

  AvailableTaskRequestAssignmentFailed({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRequestAssignmentFailed.clone(AvailableTaskInitialized state, this.error)
      : super.clone(state);
}
