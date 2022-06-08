import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
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
    final campaigns = await _gigaTurnipApiClient.getCampaigns();
    return campaigns
        .map((apiCampaign) => Campaign(
              id: apiCampaign.id,
              name: apiCampaign.name,
              description: apiCampaign.description,
            ))
        .toList();
  }

  Future<List<Task>> getTasks() async {
    final tasks = await _gigaTurnipApiClient.getTasks();
    return tasks
        .map((apiTask) => Task(
              id: apiTask.id,
              responses: apiTask.responses,
              complete: apiTask.complete,
              reopened: apiTask.reopened,
              stage: Stage(
                id: apiTask.stage.id,
                name: apiTask.stage.name,
                description: apiTask.stage.description,
                chain: Chain(
                  id: apiTask.stage.chain.id,
                  name: apiTask.stage.chain.name,
                  description: apiTask.stage.chain.description,
                  campaign: apiTask.stage.chain.campaign,
                ),
              ),
            ))
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
}
