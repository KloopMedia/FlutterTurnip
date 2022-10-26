part of 'tasks_cubit.dart';

enum Tabs {
  assignedTasksTab,
  availableTasksTab,
  // mapTab,
  timeline,
}

class TasksState extends Equatable {
  final List<Task> openTasks;
  final List<Task> closeTasks;
  final List<Task> availableTasks;
  final List<Task> allTasks;
  final List<TaskStage> creatableTasks;
  final TasksStatus status;
  final String? errorMessage;
  final Tabs selectedTab;
  final int tabIndex;
  final List<Map<String, dynamic>> graph;

  const TasksState({
    this.openTasks = const [],
    this.closeTasks = const [],
    this.availableTasks = const [],
    this.creatableTasks = const [],
    this.allTasks = const [],
    this.status = TasksStatus.uninitialized,
    this.errorMessage,
    this.selectedTab = Tabs.assignedTasksTab,
    this.tabIndex = 0,
    this.graph = const [],
  });

  // Allows to override parameters inside or returns initial one
  TasksState copyWith({
    List<TaskStage>? creatableTasks,
    List<Task>? openTasks,
    List<Task>? closeTasks,
    List<Task>? availableTasks,
    List<Task>? allTasks,
    TasksStatus? status,
    String? errorMessage,
    Tabs? selectedTab,
    int? tabIndex,
    List<Map<String, dynamic>>? graph,
  }) {
    return TasksState(
      openTasks: openTasks ?? this.openTasks,
      closeTasks: closeTasks ?? this.closeTasks,
      availableTasks: availableTasks ?? this.availableTasks,
      creatableTasks: creatableTasks ?? this.creatableTasks,
      allTasks: allTasks ?? this.allTasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      tabIndex: tabIndex ?? this.tabIndex,
      graph: graph ?? this.graph
    );
  }

  @override
  List<Object?> get props => [
        openTasks,
        closeTasks,
        availableTasks,
        creatableTasks,
        status,
        selectedTab,
        tabIndex,
        graph,
      ];
}
