part of 'available_task_cubit.dart';

class AvailableTaskRequestAssignmentSuccess extends RemoteDataInitialized<Task> {
  final Task task;

  AvailableTaskRequestAssignmentSuccess.clone(super.state, this.task) : super.clone();

  @override
  List<Object?> get props => [...super.props, task];
}

class AvailableTaskRequestAssignmentFailed extends RemoteDataInitialized<Task> {
  final String error;

  AvailableTaskRequestAssignmentFailed.clone(super.state, this.error) : super.clone();

  @override
  List<Object?> get props => [...super.props, error];
}
