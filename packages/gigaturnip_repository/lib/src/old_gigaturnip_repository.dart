// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:gigaturnip_api/gigaturnip_api.dart'
//     hide Campaign, Task, Chain, TaskStage, Notification;
// import 'package:gigaturnip_repository/old_gigaturnip_repository.dart';
//
// import 'utilities/interceptor.dart';
// import 'utilities/utilities.dart';
//
// enum TasksActions { listOpenTasks, listClosedTasks, listSelectableTasks }
//
// class GigaTurnipRepository {
//   late final GigaTurnipApiClient _gigaTurnipApiClient;
//
//   List<Task> _openedTasks = [];
//   List<Task> _closedTasks = [];
//   List<TaskStage> _userRelevantTaskStages = [];
//   List<Task> _availableTasks = [];
//   bool _hasNextAvailableTasks = false;
//   final int _pageLimit = 10;
//   int _pageOffset = 0;
//   int _totalPages = 0;
//   bool _isLoading = false;
//
//   final Duration _cacheValidDuration = const Duration(minutes: 30);
//   DateTime _tasksLastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);
//   DateTime _userRelevantTaskStagesLastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);
//
//   int get totalPages => _totalPages;
//
//   GigaTurnipRepository({
//     AuthenticationRepository? authenticationRepository,
//   }) : _gigaTurnipApiClient = GigaTurnipApiClient(DioProvider.instance(authenticationRepository!));
//
//   Future<void> refreshUserRelevantTaskStages(Campaign selectedCampaign) async {
//     final userRelevantTaskStageData = await _gigaTurnipApiClient.getUserRelevantTaskStages(
//       query: {
//         'chain__campaign': selectedCampaign.id,
//       },
//     );
//     final userRelevantTaskStages = userRelevantTaskStageData.map((apiTaskStage) {
//       return TaskStage.fromApiModel(apiTaskStage);
//     }).toList();
//
//     _userRelevantTaskStagesLastFetchTime = DateTime.now();
//     _userRelevantTaskStages = userRelevantTaskStages;
//   }
//
//   Future<List<TaskStage>> getUserRelevantTaskStages({
//     required Campaign selectedCampaign,
//     bool forceRefresh = false,
//   }) async {
//     bool shouldRefresh = true;
//     // _shouldRefreshFromApi(_userRelevantTaskStagesLastFetchTime, forceRefresh) ||
//     //     _userRelevantTaskStages.isEmpty;
//
//     if (shouldRefresh) {
//       await refreshUserRelevantTaskStages(selectedCampaign);
//     }
//     return _userRelevantTaskStages;
//   }
//
//   Future<Map<String, dynamic>> getDynamicJsonTaskStage(
//     int stageId,
//     int taskId,
//     Map<String, dynamic>? formData,
//   ) async {
//     return await _gigaTurnipApiClient.getDynamicJsonTaskStage(
//         id: stageId, formData: formData, taskId: taskId);
//   }
//
//   Future<Map<String, dynamic>> triggerWebhook(int id) async {
//     return await _gigaTurnipApiClient.triggerTaskWebhook(id: id);
//   }
//
//   Future<void> refreshAllTasks(Campaign selectedCampaign, TasksActions action) async {
//     switch (action) {
//       case TasksActions.listOpenTasks:
//         final openedTasksData = await _gigaTurnipApiClient.getUserRelevantTasks(
//           query: {
//             'complete': false,
//             'stage__chain__campaign': selectedCampaign.id,
//           },
//         );
//         _openedTasks = openedTasksData.map((apiTask) {
//           return Task.fromApiModel(apiTask);
//         }).toList();
//         break;
//       case TasksActions.listClosedTasks:
//         final closedTasksData = await _gigaTurnipApiClient.getUserRelevantTasks(
//           query: {
//             'complete': true,
//             'stage__chain__campaign': selectedCampaign.id,
//           },
//         );
//         _closedTasks = closedTasksData.map((apiTask) {
//           return Task.fromApiModel(apiTask);
//         }).toList();
//         break;
//       case TasksActions.listSelectableTasks:
//         final availableTasksData = await _gigaTurnipApiClient.getUserSelectableTasks(
//           query: {
//             'stage__chain__campaign': selectedCampaign.id,
//             'limit': _pageLimit,
//           },
//         );
//         _availableTasks = availableTasksData.results.map((apiTask) {
//           return Task.fromApiModel(apiTask);
//         }).toList();
//         _hasNextAvailableTasks = availableTasksData.hasNext;
//         _pageOffset = 0;
//         _totalPages = (availableTasksData.count / _pageLimit).floor();
//         break;
//     }
//     _tasksLastFetchTime = DateTime.now();
//   }
//
//   Future<List<Task>> getNextTasksPage(Campaign selectedCampaign) async {
//     if (_hasNextAvailableTasks && !_isLoading) {
//       _isLoading = true;
//       _pageOffset += _pageLimit;
//
//       final availableTasksData = await _gigaTurnipApiClient.getUserSelectableTasks(
//         query: {
//           'stage__chain__campaign': selectedCampaign.id,
//           'limit': _pageLimit,
//           'offset': _pageOffset,
//         },
//       );
//       _isLoading = false;
//       _totalPages = (availableTasksData.count / _pageLimit).floor();
//       _hasNextAvailableTasks = availableTasksData.hasNext;
//
//       final availableTasks = availableTasksData.results.map((apiTask) {
//         return Task.fromApiModel(apiTask);
//       }).toList();
//
//       _availableTasks.addAll(availableTasks);
//     }
//     return _availableTasks;
//   }
//
//   Future<List<Task>> getIntegratedTasks(int id) async {
//     final tasks = await _gigaTurnipApiClient.getIntegratedTasks(id: id);
//     return tasks.map((task) => Task.fromApiModel(task)).toList();
//   }
//
//   Future<List<Task>> getTasksPage(Campaign selectedCampaign, int page) async {
//     if (!_isLoading) {
//       _isLoading = true;
//       _pageOffset = page * _pageLimit;
//
//       final availableTasksData = await _gigaTurnipApiClient.getUserSelectableTasks(
//         query: {
//           'stage__chain__campaign': selectedCampaign.id,
//           'limit': _pageLimit,
//           'offset': _pageOffset,
//         },
//       );
//       _isLoading = false;
//       _totalPages = (availableTasksData.count / _pageLimit).floor();
//       _hasNextAvailableTasks = availableTasksData.hasNext;
//
//       final availableTasks = availableTasksData.results.map((apiTask) {
//         return Task.fromApiModel(apiTask);
//       }).toList();
//
//       _availableTasks = availableTasks;
//     }
//     return _availableTasks;
//   }
//
//   Future<List<Task>> getPreviousTasksPage(Campaign selectedCampaign) async {
//     if (_hasNextAvailableTasks && !_isLoading) {
//       _isLoading = true;
//       _pageOffset -= _pageLimit;
//
//       final availableTasksData = await _gigaTurnipApiClient.getUserSelectableTasks(
//         query: {
//           'stage__chain__campaign': selectedCampaign.id,
//           'limit': _pageLimit,
//           'offset': _pageOffset,
//         },
//       );
//       _isLoading = false;
//       _totalPages = (availableTasksData.count / _pageLimit).floor();
//       _hasNextAvailableTasks = availableTasksData.hasNext;
//
//       final availableTasks = availableTasksData.results.map((apiTask) {
//         return Task.fromApiModel(apiTask);
//       }).toList();
//
//       _availableTasks.addAll(availableTasks);
//     }
//     return _availableTasks;
//   }
//
//   Future<Task> createTask(int id) async {
//     final taskId = await _gigaTurnipApiClient.createTask(id: id);
//     final task = await _gigaTurnipApiClient.getTaskById(id: taskId);
//     return Task.fromApiModel(task);
//   }
//
//   Future<List<Task>> getTasks({
//     required TasksActions action,
//     required Campaign selectedCampaign,
//     bool forceRefresh = false,
//   }) async {
//     bool shouldRefresh = true;
//     // shouldRefreshFromApi( _tasksLastFetchTime, forceRefresh) || _openedTasks.isEmpty;
//
//     if (shouldRefresh) {
//       await refreshAllTasks(selectedCampaign, action);
//     }
//
//     switch (action) {
//       case TasksActions.listOpenTasks:
//         return _openedTasks;
//       case TasksActions.listClosedTasks:
//         return _closedTasks;
//       case TasksActions.listSelectableTasks:
//         return _availableTasks;
//     }
//   }
//
//   Future<List<Notifications>?> getNotifications(int campaignId, bool viewed,
//       [int? importance]) async {
//     final notificationsData = await _gigaTurnipApiClient.getUserNotifications(
//       query: {'campaign': campaignId, 'viewed': viewed, 'importance': importance},
//     );
//     final notifications = notificationsData.results.map((apiNotification) {
//       return Notifications.fromApiModel(apiNotification);
//     }).toList();
//     return notifications;
//   }
//
//   Future<void> getOpenNotification(int id) async {
//     await _gigaTurnipApiClient.openNotification(id: id);
//   }
//
//   Future<Task> getTask(int id) async {
//     final response = await _gigaTurnipApiClient.getTaskById(id: id);
//     return Task.fromApiModel(response);
//   }
//
//   Future<int?> updateTask(Task task) async {
//     final data = task.toJson();
//     final response = await _gigaTurnipApiClient.updateTaskById(
//       id: task.id,
//       data: data,
//     );
//     if (response.containsKey('next_direct_id')) {
//       return response['next_direct_id'];
//     }
//     return null;
//   }
//
//   Future<List<Task>> getPreviousTasks(int id) async {
//     final tasks = await _gigaTurnipApiClient.getDisplayedPreviousTasks(id: id);
//     return tasks.map((task) => Task.fromApiModel(task)).toList();
//   }
//
//   Future<void> requestTask(int id) async {
//     await _gigaTurnipApiClient.requestTask(id: id);
//   }
// }