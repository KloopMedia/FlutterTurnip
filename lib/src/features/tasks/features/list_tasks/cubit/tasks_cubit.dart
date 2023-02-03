import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
// import 'package:hive/hive.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final Campaign selectedCampaign;
  final List<Task> closeTasks = [];

  TasksCubit({
    required this.gigaTurnipRepository,
    required this.selectedCampaign,
  }) : super(const TasksState());

  void initialize() async {
    // refresh();
    initialLoading();
    getUnreadNotifications();
  }

  void initializeCombined() async {
    // refreshCombined();
    initialLoadingCombined();
    getUnreadNotifications();
  }

  void initialLoadingCombined() async {
    emit(state.copyWith(status: TasksStatus.loading));
    // await Hive.openBox<Task>(selectedCampaign.name);
    // final closeTasks = await _writeDataToBox();
    final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
    final availableTasks = await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
    final creatableTasks = await _fetchCreatableTasks(forceRefresh: true);
    final totalPages = gigaTurnipRepository.totalPages;

    emit(state.copyWith(
      totalPages: totalPages,
      openTasks: openTasks,
      closeTasks: closeTasks,
      availableTasks: availableTasks,
      creatableTasks: creatableTasks,
      status: TasksStatus.initialized,
    ));
  }

  void refreshCombined() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
    // final closeTasks = await _writeDataToBox();
    // final closeTasks = await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
    final availableTasks = await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
    final creatableTasks = await _fetchCreatableTasks(forceRefresh: true);
    final totalPages = gigaTurnipRepository.totalPages;

    emit(state.copyWith(
      totalPages: totalPages,
      openTasks: openTasks,
      closeTasks: closeTasks,
      availableTasks: availableTasks,
      creatableTasks: creatableTasks,
      status: TasksStatus.initialized,
    ));
  }

  void initialLoading() async {
    emit(state.copyWith(status: TasksStatus.loading));
    // await Hive.openBox<Task>(selectedCampaign.name);
    final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
    // final closeTasks = await _writeDataToBox();
    emit(state.copyWith(
      openTasks: openTasks,
      closeTasks: closeTasks,
    ));
    emit(state.copyWith(status: TasksStatus.initialized));
  }

  void refresh() async {
    emit(state.copyWith(status: TasksStatus.loading));
    switch (state.selectedTab) {
      case Tabs.assignedTasksTab:
        final openTasks = await _fetchData(action: TasksActions.listOpenTasks, forceRefresh: true);
        // final closeTasks = await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
        // final closeTasks = await _writeDataToBox();
        emit(state.copyWith(
          openTasks: openTasks,
          closeTasks: closeTasks,
        ));
        break;
      case Tabs.availableTasksTab:
        final availableTasks =
            await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
        final creatableTasks = await _fetchCreatableTasks(forceRefresh: true);
        final totalPages = gigaTurnipRepository.totalPages;

        emit(state.copyWith(
          totalPages: totalPages,
          availableTasks: availableTasks,
          creatableTasks: creatableTasks,
        ));
        break;
    }
    emit(state.copyWith(status: TasksStatus.initialized));
  }

  // Future<List<Task>> _writeDataToBox() async {
  //   final closeTasks = await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
  //   final closedTasksBox = Hive.box<Task>(selectedCampaign.name);
  //   closedTasksBox.clear();
  //   if (closeTasks != null && closeTasks.isNotEmpty) {
  //     for(var task in closeTasks) {
  //       closedTasksBox.put(task.id, task);
  //     }
  //   }
  //   final closedTasksFromBox = _readDataFromBox();
  //   return closedTasksFromBox;
  // }
  //
  // Future<List<Task>> _readDataFromBox() async {
  //   final closedTasksBox = Hive.box<Task>(selectedCampaign.name);
  //   for (var key in closedTasksBox.keys.toList().reversed) {
  //     final task = closedTasksBox.get(key);
  //     closeTasks.add(task!);
  //   }
  //   return closeTasks;
  // }
  //
  // void closeHiveBox() {
  //   Hive.box<Task>(selectedCampaign.name).close();
  // }

  Future<void> getNextPage() async {
    emit(state.copyWith(status: TasksStatus.loadingNextPage));
    final tasks = await gigaTurnipRepository.getNextTasksPage(selectedCampaign);
    emit(state.copyWith(availableTasks: tasks, status: TasksStatus.initialized));
  }

  Future<void> getPreviousPage() async {
    emit(state.copyWith(status: TasksStatus.loadingNextPage));
    final tasks = await gigaTurnipRepository.getPreviousTasksPage(selectedCampaign);
    emit(state.copyWith(availableTasks: tasks, status: TasksStatus.initialized));
  }

  Future<void> getPage(int page) async {
    emit(state.copyWith(status: TasksStatus.loadingNextPage));
    final tasks = await gigaTurnipRepository.getTasksPage(selectedCampaign, page);
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
        // final closeTasks = await _fetchData(action: TasksActions.listClosedTasks, forceRefresh: true);
        // final closeTasks = await _readDataFromBox();
        emit(state.copyWith(
          openTasks: openTasks,
          closeTasks: closeTasks,
        ));
        break;
      case Tabs.availableTasksTab:
        final availableTasks =
            await _fetchData(action: TasksActions.listSelectableTasks, forceRefresh: true);
        final creatableTasks = await _fetchCreatableTasks(forceRefresh: true);
        final totalPages = gigaTurnipRepository.totalPages;
        print('TOTAL: $totalPages');
        emit(state.copyWith(
          totalPages: totalPages,
          availableTasks: availableTasks,
          creatableTasks: creatableTasks,
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
      default:
        throw Exception('Unknown index $index');
    }
  }

  // Future<FileModel> getFile(path) async {
  //   final ref = firebase_storage.FirebaseStorage.instance.ref(path);
  //   final data = await ref.getMetadata();
  //   final url = await ref.getDownloadURL();
  //   final type = _getFileType(data.contentType);
  //   return FileModel(name: data.name, path: data.fullPath, type: type, url: url);
  // }
  //
  // FileType _getFileType(String? contentType) {
  //   final type = contentType?.split('/').first;
  //   switch (type) {
  //     case 'video':
  //       return FileType.video;
  //     case 'image':
  //       return FileType.image;
  //     default:
  //       return FileType.any;
  //   }
  // }

  void getUnreadNotifications() async {
    try {
      List<Notifications>? unreadNotifications = [];
      unreadNotifications = await gigaTurnipRepository.getNotifications(selectedCampaign.id, false);
      if (unreadNotifications == null || unreadNotifications.isEmpty) {
        emit(state.copyWith(hasUnreadNotifications: false));
      } else {
        emit(state.copyWith(hasUnreadNotifications: true));
      }
    } on GigaTurnipApiRequestException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to load notifications',
      ));
    }
  }
}
