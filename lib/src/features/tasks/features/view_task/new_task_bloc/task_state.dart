part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  final Task task;

  copyWith({Task? task});

  const TaskState({required this.task});
}

class CommonTask extends TaskState {
  final List<Task> previousTasks;

  const CommonTask({required super.task, this.previousTasks = const []});

  @override
  List<Object?> get props => [task, previousTasks];

  @override
  CommonTask copyWith({Task? task, List<Task>? previousTasks}) =>
      CommonTask(task: task ?? this.task, previousTasks: previousTasks ?? this.previousTasks);
}

class IntegratedTask extends TaskState {
  final List<Task> integratedTasks;

  const IntegratedTask({required super.task, this.integratedTasks = const []});

  @override
  List<Object?> get props => [task, integratedTasks];

  @override
  IntegratedTask copyWith({Task? task, List<Task>? integratedTasks}) => IntegratedTask(
      task: task ?? this.task, integratedTasks: integratedTasks ?? this.integratedTasks);
}
