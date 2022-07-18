import 'dart:async';
import 'package:dio/dio.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' hide Campaign, Task, Chain, TaskStage;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

enum CampaignsActions { listUserCampaigns, listSelectableCampaigns }

enum TasksActions { listOpenTasks, listClosedTasks, listSelectableTasks }

class GigaTurnipRepository {
  late final GigaTurnipApiClient _gigaTurnipApiClient;

  List<Campaign> _userCampaigns = [];
  List<Campaign> _selectableCampaigns = [];
  List<Task> _openedTasks = [];
  List<Task> _closedTasks = [];
  List<TaskStage> _userRelevantTaskStages = [];
  List<Task> _availableTasks = [];

  final Duration _cacheValidDuration = const Duration(minutes: 30);
  DateTime _campaignLastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _tasksLastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);
  DateTime _userRelevantTaskStagesLastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);

  GigaTurnipRepository({
    AuthenticationRepository? authenticationRepository,
  }) {
    _gigaTurnipApiClient = GigaTurnipApiClient(
      httpClient: Dio(BaseOptions(baseUrl: GigaTurnipApiClient.baseUrl))
        ..interceptors.add(
          ApiInterceptors(authenticationRepository ?? AuthenticationRepository()),
        ),
    );
  }

  bool _shouldRefreshFromApi(DateTime lastFetchTime, bool forceRefresh) {
    return lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) || forceRefresh;
  }

  Future<void> refreshAllCampaigns() async {
    final userCampaignsData = await _gigaTurnipApiClient.getUserCampaigns();
    final userCampaigns = userCampaignsData.map((apiCampaign) {
      return Campaign.fromApiModel(apiCampaign);
    }).toList();

    final selectableCampaignsData = await _gigaTurnipApiClient.getSelectableCampaigns();
    final selectableCampaigns = selectableCampaignsData.map((apiCampaign) {
      return Campaign.fromApiModel(apiCampaign);
    }).toList();

    _campaignLastFetchTime = DateTime.now();
    _userCampaigns = userCampaigns;
    _selectableCampaigns = selectableCampaigns;
  }

  Future<List<Campaign>> getCampaigns({
    required CampaignsActions action,
    bool forceRefresh = false,
  }) async {
    bool shouldRefreshFromApi =
        _shouldRefreshFromApi(_campaignLastFetchTime, forceRefresh) || _userCampaigns.isEmpty;

    if (shouldRefreshFromApi) {
      await refreshAllCampaigns();
    }
    if (action == CampaignsActions.listUserCampaigns) {
      return _userCampaigns;
    } else {
      return _selectableCampaigns;
    }
  }

  Future<void> refreshUserRelevantTaskStages(Campaign selectedCampaign) async {
    final userRelevantTaskStageData = await _gigaTurnipApiClient.getUserRelevantTaskStages(
      query: {
        'chain__campaign': selectedCampaign.id,
      },
    );
    final userRelevantTaskStages = userRelevantTaskStageData.map((apiTaskStage) {
      return TaskStage.fromApiModel(apiTaskStage);
    }).toList();

    _userRelevantTaskStagesLastFetchTime = DateTime.now();
    _userRelevantTaskStages = userRelevantTaskStages;
  }

  Future<List<TaskStage>> getUserRelevantTaskStages({
    required Campaign selectedCampaign,
    bool forceRefresh = false,
  }) async {
    bool shouldRefreshFromApi =
        _shouldRefreshFromApi(_userRelevantTaskStagesLastFetchTime, forceRefresh) ||
            _userRelevantTaskStages.isEmpty;

    if (shouldRefreshFromApi) {
      await refreshUserRelevantTaskStages(selectedCampaign);
    }
    return _userRelevantTaskStages;
  }

  Future<void> refreshAllTasks(Campaign selectedCampaign) async {
    final openedTasksData = await _gigaTurnipApiClient.getUserRelevantTasks(
      query: {
        'complete': false,
        'stage__chain__campaign': selectedCampaign.id,
      },
    );
    final openedTasks = openedTasksData.map((apiTask) {
      return Task.fromApiModel(apiTask);
    }).toList();

    final closedTasksData = await _gigaTurnipApiClient.getUserRelevantTasks(
      query: {
        'complete': true,
        'stage__chain__campaign': selectedCampaign.id,
      },
    );
    final closedTasks = closedTasksData.map((apiTask) {
      return Task.fromApiModel(apiTask);
    }).toList();

    final availableTasksData = await _gigaTurnipApiClient.getUserSelectableTasks(
      query: {
        'stage__chain__campaign': selectedCampaign.id,
      },
    );
    final availableTasks = availableTasksData.results.map((apiTask) {
      return Task.fromApiModel(apiTask);
    }).toList();

    _tasksLastFetchTime = DateTime.now();
    _openedTasks = openedTasks;
    _closedTasks = closedTasks;
    _availableTasks = availableTasks;
  }

  Future<Task> createTask(int id) async {
    final taskId = await _gigaTurnipApiClient.createTask(id: id);
    final task = await _gigaTurnipApiClient.getTaskById(id: taskId);
    return Task.fromApiModel(task);
  }

  Future<List<Task>> getTasks({
    required TasksActions action,
    required Campaign selectedCampaign,
    bool forceRefresh = false,
  }) async {
    bool shouldRefreshFromApi =
        _shouldRefreshFromApi(_tasksLastFetchTime, forceRefresh) || _openedTasks.isEmpty;

    if (shouldRefreshFromApi) {
      await refreshAllTasks(selectedCampaign);
    }

    switch (action) {
      case TasksActions.listOpenTasks:
        return _openedTasks;
      case TasksActions.listClosedTasks:
        return _closedTasks;
      case TasksActions.listSelectableTasks:
        return _availableTasks;
    }
  }

  Future<Task> getTask(int id) async {
    final response = await _gigaTurnipApiClient.getTaskById(id: id);
    return Task.fromApiModel(response);
  }

  Future<int?> updateTask(Task task) async {
    final data = task.toJson();
    final response = await _gigaTurnipApiClient.updateTaskById(
      id: task.id,
      data: data,
    );
    if (response.containsKey('next_direct_id')) {
      return response['next_direct_id'];
    }
    return null;
  }

  Future<List<Task>> getPreviousTasks(int id) async {
    final tasks = await _gigaTurnipApiClient.getDisplayedPreviousTasks(id: id);
    return tasks.map((task) => Task.fromApiModel(task)).toList();
  }
}

class ApiInterceptors extends Interceptor {
  final AuthenticationRepository _authenticationRepository;

  ApiInterceptors(this._authenticationRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await _authenticationRepository.token;

    options.headers['Authorization'] = 'JWT $accessToken';

    return handler.next(options);
  }
}
