part of 'tasks_cubit.dart';

enum TasksStatus {
  uninitialized,
  loading,
  initialized,
  error,
}

class TasksState extends Equatable {
  final List<Task> tasks;
  final TasksStatus status;
  final String? errorMessage;

  const TasksState({
    this.status = TasksStatus.uninitialized,
    this.errorMessage,
    this.tasks = const [],
  });

  TasksState copyWith({
    List<Task>? tasks,
    TasksStatus? status,
    String? errorMessage,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [tasks, status];
}
