import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' hide Campaign, Task, Stage, Chain;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class GigaTurnipRepository {
  late final GigaTurnipApiClient _gigaTurnipApiClient;

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

  Future<List<Campaign>> getCampaigns() async {
    final data = await _gigaTurnipApiClient.getCampaigns();
    final campaigns = data.results;
    return campaigns
        .map((apiCampaign) => Campaign.fromApiModel(apiCampaign))
        .toList();
  }

  Future<List<Task>> getTasks() async {
    final tasks = await _gigaTurnipApiClient.getTasks();
    return tasks.results
        .map((apiTask) => Task.fromApiModel(apiTask))
        .toList();
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

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
