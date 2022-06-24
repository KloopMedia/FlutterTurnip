import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final Campaign selectedCampaign;

  TasksCubit({
    required this.gigaTurnipRepository,
    required this.selectedCampaign,
  }) : super(const TasksState());

  void initialize() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final data = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
    if (data != null) {
      emit(state.copyWith(tasks: data, status: TasksStatus.initialized));
    }
  }

  void refresh() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final action = _getActionFromTab(state.selectedTab);
    final data = await _fetchData(action: action, forceRefresh: true);
    if (data != null) {
      emit(state.copyWith(tasks: data, status: TasksStatus.initialized));
    }
  }

  void onTabChange(int index) async {
    emit(state.copyWith(status: TasksStatus.loading));
    final tab = _getTabFromIndex(index);
    final action = _getActionFromTab(tab);
    emit(state.copyWith(selectedTab: tab, tabIndex: index));
    final data = await _fetchData(action: action);
    if (data != null) {
      emit(state.copyWith(tasks: data, status: TasksStatus.initialized));
    }
  }

  Future<List<Task>?> _fetchData({required TasksActions action, bool forceRefresh = false}) async {
    try {
      return await gigaTurnipRepository.getTasks(
        action: action,
        selectedCampaign: selectedCampaign,
        forceRefresh: forceRefresh,
      );
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
    return null;
  }

  TasksActions _getActionFromTab(Tabs tab) {
    switch (tab) {
      case Tabs.openTasksTab:
        return TasksActions.listOpenTasks;
      case Tabs.closedTasksTab:
        return TasksActions.listClosedTasks;
      case Tabs.availableTasksTab:
        return TasksActions.listSelectableTasks;
    }
  }

  Tabs _getTabFromIndex(int index) {
    switch (index) {
      case 0:
        return Tabs.openTasksTab;
      case 1:
        return Tabs.closedTasksTab;
      case 2:
        return Tabs.availableTasksTab;
      default:
        throw Exception('Unknown index $index');
    }
  }
}
