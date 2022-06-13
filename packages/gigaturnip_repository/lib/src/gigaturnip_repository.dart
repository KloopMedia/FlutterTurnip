import 'dart:async';
import 'package:dio/dio.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' hide Campaign, Task, Stage, Chain;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class GigaTurnipRepository {
  late final GigaTurnipApiClient _gigaTurnipApiClient;

  List<Campaign> _campaigns = [];
  List<Task> _tasks = [];

  final Duration _cacheValidDuration = const Duration(minutes: 30);
  DateTime _campaignLastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _tasksLastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);

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

  List<Campaign> get allCampaigns => _campaigns;

  List<Task> get allTasks => _tasks;

  bool _shouldRefreshFromApi(DateTime lastFetchTime, bool forceRefresh) {
    return lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) || forceRefresh;
  }

  Future<void> refreshAllCampaigns() async {
    final data = await _gigaTurnipApiClient.getCampaigns();
    final campaigns = data.results.map((apiCampaign) {
      return Campaign.fromApiModel(apiCampaign);
    }).toList();
    _campaignLastFetchTime = DateTime.now();
    _campaigns = campaigns;
  }

  Future<List<Campaign>> getCampaigns({bool forceRefresh = false}) async {
    bool shouldRefreshFromApi =
        _shouldRefreshFromApi(_campaignLastFetchTime, forceRefresh) || _campaigns.isEmpty;

    if (shouldRefreshFromApi) {
      await refreshAllCampaigns();
    }
    return _campaigns;
  }

  Future<void> refreshAllTasks() async {
    final data = await _gigaTurnipApiClient.getTasks();
    final tasks = data.results.map((apiTask) {
      return Task.fromApiModel(apiTask);
    }).toList();
    _tasksLastFetchTime = DateTime.now();
    _tasks = tasks;
  }

  Future<List<Task>> getTasks({bool forceRefresh = false}) async {
    bool shouldRefreshFromApi =
        _shouldRefreshFromApi(_tasksLastFetchTime, forceRefresh) || _tasks.isEmpty;

    if (shouldRefreshFromApi) {
      await refreshAllTasks();
    }
    return _tasks;
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
