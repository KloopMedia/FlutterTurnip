import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final AuthenticationRepository authenticationRepository;
  final GigaTurnipRepository gigaTurnipRepository;
  final Campaign selectedCampaign;

  TasksCubit({
    required this.gigaTurnipRepository,
    required this.authenticationRepository,
    required this.selectedCampaign,
  }) : super(const TasksState());

  void loadTasks({
    bool forceRefresh = false,
  }) async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      late final List<Task> tasks;
      switch (state.selectedTab) {
        case Tabs.openTasksTab:
          tasks = await gigaTurnipRepository.getTasks(
            action: TasksActions.listOpenTasks,
            selectedCampaign: selectedCampaign,
            forceRefresh: forceRefresh,
          );
          break;
        case Tabs.closedTasksTab:
          tasks = await gigaTurnipRepository.getTasks(
            action: TasksActions.listClosedTasks,
            selectedCampaign: selectedCampaign,
            forceRefresh: forceRefresh,
          );
          break;
        case Tabs.availableTasksTab:
          tasks = await gigaTurnipRepository.getTasks(
            action: TasksActions.listSelectableTasks,
            selectedCampaign: selectedCampaign,
            forceRefresh: forceRefresh,
          );
          break;
        default:
          throw Exception('Unknown tab was selected');
      }
      emit(state.copyWith(tasks: tasks, status: TasksStatus.initialized));
    } on GigaTurnipApiRequestException catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: e.message,
          tasks: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: 'Failed to load tasks',
          tasks: [],
        ),
      );
    }
  }

  void onTabChange(int index) {
    if (index == 0) {
      emit(state.copyWith(selectedTab: Tabs.openTasksTab, tabIndex: index));
    } else if (index == 1) {
      emit(state.copyWith(selectedTab: Tabs.closedTasksTab, tabIndex: index));
    } else if (index == 2) {
      emit(state.copyWith(selectedTab: Tabs.availableTasksTab, tabIndex: index));
    }
    loadTasks();
  }
}
