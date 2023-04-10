part of 'available_task_cubit.dart';

class AvailableTaskRequestAssignmentSuccess extends RemoteDataInitialized<Task> {
  final Task task;

  AvailableTaskRequestAssignmentSuccess({
    required this.task,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRequestAssignmentSuccess.clone(super.state, this.task) : super.clone();

  @override
  List<Object> get props => [...super.props, task];
}

class AvailableTaskRequestAssignmentFailed extends RemoteDataInitialized<Task> {
  final String error;

  AvailableTaskRequestAssignmentFailed({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  AvailableTaskRequestAssignmentFailed.clone(super.state, this.error) : super.clone();

  @override
  List<Object> get props => [...super.props, error];
}
