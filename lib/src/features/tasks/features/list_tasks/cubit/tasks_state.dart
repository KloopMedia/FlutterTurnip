part of 'tasks_cubit.dart';

enum Tabs {
  openTasksTab,
  closedTasksTab,
  availableTasksTab,
}

class TasksState extends Equatable {
  final Map<String, List<Task>> tasks;
  final TasksStatus status;
  final String? errorMessage;
  final Tabs selectedTab;
  final int tabIndex;

  const TasksState({
    this.status = TasksStatus.uninitialized,
    this.errorMessage,
    this.tasks = const {},
    this.selectedTab = Tabs.openTasksTab,
    this.tabIndex = 0,
  });

  TasksState copyWith({
    Map<String, List<Task>>? tasks,
    TasksStatus? status,
    String? errorMessage,
    Tabs? selectedTab,
    int? tabIndex,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  @override
  List<Object?> get props => [tasks, status, selectedTab, tabIndex];
}
