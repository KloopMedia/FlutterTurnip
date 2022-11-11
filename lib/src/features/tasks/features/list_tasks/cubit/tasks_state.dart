part of 'tasks_cubit.dart';

enum Tabs {
  assignedTasksTab,
  availableTasksTab,
}

class TasksState extends Equatable {
  final int totalPages;
  final List<Task> openTasks;
  final List<Task> closeTasks;
  final List<Task> availableTasks;
  final List<TaskStage> creatableTasks;
  final TasksStatus status;
  final String? errorMessage;
  final Tabs selectedTab;
  final int tabIndex;
  final bool hasUnreadNotifications;

  const TasksState({
    this.totalPages = 0,
    this.openTasks = const [],
    this.closeTasks = const [],
    this.availableTasks = const [],
    this.creatableTasks = const [],
    this.status = TasksStatus.uninitialized,
    this.errorMessage,
    this.selectedTab = Tabs.assignedTasksTab,
    this.tabIndex = 0,
    this.hasUnreadNotifications = false,
  });

  TasksState copyWith({
    int? totalPages,
    List<TaskStage>? creatableTasks,
    List<Task>? openTasks,
    List<Task>? closeTasks,
    List<Task>? availableTasks,
    TasksStatus? status,
    String? errorMessage,
    Tabs? selectedTab,
    int? tabIndex,
    bool? hasUnreadNotifications,
  }) {
    return TasksState(
      totalPages: totalPages ?? this.totalPages,
      openTasks: openTasks ?? this.openTasks,
      closeTasks: closeTasks ?? this.closeTasks,
      availableTasks: availableTasks ?? this.availableTasks,
      creatableTasks: creatableTasks ?? this.creatableTasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      tabIndex: tabIndex ?? this.tabIndex,
        hasUnreadNotifications: hasUnreadNotifications ?? this.hasUnreadNotifications,
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
        hasUnreadNotifications,
      ];
}
