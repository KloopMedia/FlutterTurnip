import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' hide Campaign, Task, Stage, Chain;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class GigaTurnipRepository {
  late final GigaTurnipApiClient _gigaTurnipApiClient;

  List<Campaign> _campaigns = [];
  final Duration _cacheValidDuration = const Duration(minutes: 30);
  DateTime _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);

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

  bool _shouldRefreshFromApi(bool forceRefresh) {
    return _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) || forceRefresh;
  }

  Future<void> refreshAllCampaigns() async {
    final data = await _gigaTurnipApiClient.getCampaigns(); // This makes the actual HTTP request
    final campaigns = data.results.map((apiCampaign) {
      return Campaign.fromApiModel(apiCampaign);
    }).toList();
    _lastFetchTime = DateTime.now();
    _campaigns = campaigns;
  }

  Future<List<Campaign>> getCampaigns({bool forceRefresh = false}) async {
    bool shouldRefreshFromApi =_shouldRefreshFromApi(forceRefresh) || _campaigns.isEmpty;

    if (shouldRefreshFromApi) {
      await refreshAllCampaigns();
    }
    return _campaigns;
  }

  Future<List<Task>> getTasks() async {
    final tasks = await _gigaTurnipApiClient.getTasks();
    return tasks.results.map((apiTask) => Task.fromApiModel(apiTask)).toList();
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
