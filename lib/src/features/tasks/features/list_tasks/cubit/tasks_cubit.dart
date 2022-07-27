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
    refresh();
  }

  void refresh() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
    final closeTasks = await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
    final availableTasks =
        await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
    final creatableTasks = await _fetchCreatableTasks(forceRefresh: true);
    emit(state.copyWith(
      openTasks: openTasks,
      closeTasks: closeTasks,
      availableTasks: availableTasks,
      creatableTasks: creatableTasks,
      status: TasksStatus.initialized,
    ));
  }

  Future<Task> createTask(TaskStage taskStage) async {
    try {
      return await gigaTurnipRepository.createTask(taskStage.id);
    } on GigaTurnipApiRequestException catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: e.message,
        ),
      );
      rethrow;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: 'Failed to create tasks: $e',
        ),
      );
      rethrow;
    }
  }

  void onTabChange(int index) async {
    emit(state.copyWith(status: TasksStatus.loading));
    final tab = _getTabFromIndex(index);
    emit(state.copyWith(selectedTab: tab, tabIndex: index, status: TasksStatus.initialized));
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
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: 'Failed to load tasks',
        ),
      );
    }
    return null;
  }

  Future<List<TaskStage>> _fetchCreatableTasks({bool forceRefresh = false}) async {
    try {
      return await gigaTurnipRepository.getUserRelevantTaskStages(
        selectedCampaign: selectedCampaign,
        forceRefresh: forceRefresh,
      );
    } on GigaTurnipApiRequestException catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: e.message,
        ),
      );
      rethrow;
    } catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: 'Failed to load tasks',
        ),
      );
      rethrow;
    }
  }

  Tabs _getTabFromIndex(int index) {
    switch (index) {
      case 0:
        return Tabs.assignedTasksTab;
      case 1:
        return Tabs.availableTasksTab;
      default:
        throw Exception('Unknown index $index');
    }
  }
}
