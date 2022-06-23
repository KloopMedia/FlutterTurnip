part of 'task_bloc.dart';

@immutable
class TaskState extends Equatable {
  final Task task;

  const TaskState(this.task);

  @override
  List<Object?> get props => [task];
}
