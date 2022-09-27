import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:uniturnip/json_schema_ui.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


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

  void initializeCombined() async {
    refreshCombined();
  }

  void refreshCombined() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
    final closeTasks = await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
    final availableTasks = await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
    final creatableTasks = await _fetchCreatableTasks(forceRefresh: true);
    emit(state.copyWith(
      openTasks: openTasks,
      closeTasks: closeTasks,
      availableTasks: availableTasks,
      creatableTasks: creatableTasks,
      status: TasksStatus.initialized,
    ));
  }

  void refresh() async {
    emit(state.copyWith(status: TasksStatus.loading));
    switch (state.selectedTab) {
      case Tabs.assignedTasksTab:
        final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
        final closeTasks = await _fetchData(action: TasksActions.listClosedTasks);
        emit(state.copyWith(
          openTasks: openTasks,
          closeTasks: closeTasks,
        ));
        break;
      case Tabs.availableTasksTab:
        final availableTasks = await _fetchData(action: TasksActions.listSelectableTasks);
        final creatableTasks = await _fetchCreatableTasks();
        emit(state.copyWith(
          availableTasks: availableTasks,
          creatableTasks: creatableTasks,
        ));
        break;
      case Tabs.mapTab:
        final allTasks = await _fetchData(action: TasksActions.allTasks);
        emit(state.copyWith(
          allTasks: allTasks,
        ));
        break;
    }
    emit(state.copyWith(status: TasksStatus.initialized));
  }

  Future<void> getNextPage() async {
    emit(state.copyWith(status: TasksStatus.loadingNextPage));
    final tasks = await gigaTurnipRepository.getNextTasksPage(selectedCampaign);
    emit(state.copyWith(availableTasks: tasks, status: TasksStatus.initialized));
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

  Future<void> requestTask(Task task) async {
    try {
      await gigaTurnipRepository.requestTask(task.id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void onTabChange(int index) async {
    emit(state.copyWith(status: TasksStatus.loading));
    final tab = _getTabFromIndex(index);
    switch (tab) {
      case Tabs.assignedTasksTab:
        final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
        final closeTasks =
            await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
        emit(state.copyWith(
          openTasks: openTasks,
          closeTasks: closeTasks,
        ));
        break;
      case Tabs.availableTasksTab:
        final availableTasks =
            await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
        final creatableTasks = await _fetchCreatableTasks();
        emit(state.copyWith(
          availableTasks: availableTasks,
          creatableTasks: creatableTasks,
        ));
        break;
      case Tabs.mapTab:
        final allTasks = await _fetchData(action: TasksActions.allTasks, forceRefresh: true);
        emit(state.copyWith(
          allTasks: allTasks,
        ));
        break;
    }
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
      case 2:
        return Tabs.mapTab;
      default:
        throw Exception('Unknown index $index');
    }
  }

  Future<FileModel> getFile(path) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref(path);
    final data = await ref.getMetadata();
    final url = await ref.getDownloadURL();
    final type = _getFileType(data.contentType);
    return FileModel(name: data.name, path: data.fullPath, type: type, url: url);
  }

  FileType _getFileType(String? contentType) {
    final type = contentType?.split('/').first;
    switch (type) {
      case 'video':
        return FileType.video;
      case 'image':
        return FileType.image;
      default:
        return FileType.any;
    }
  }

  void getGraph(int id) async {
    try {
      final graph = await gigaTurnipRepository.getGraph(id);
      emit(state.copyWith(
          graph: graph
      ));
    } catch (e) {
      rethrow;
    }

  }
}
