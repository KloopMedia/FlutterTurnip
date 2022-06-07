import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' hide Campaign;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class WeatherFailure implements Exception {}

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

class GigaTurnipRepository {
  GigaTurnipRepository(
      {AuthenticationRepository? authenticationRepository,
      GigaTurnipApiClient? gigaTurnipApiClient})
      : _gigaTurnipApiClient = gigaTurnipApiClient ??
            GigaTurnipApiClient(
                httpClient: Dio(
              BaseOptions(
                baseUrl: GigaTurnipApiClient.baseUrl,
              ),
            )..interceptors
                    .add(ApiInterceptors(authenticationRepository ?? AuthenticationRepository()))),
        _authenticationRepository = authenticationRepository ?? AuthenticationRepository();

  final GigaTurnipApiClient _gigaTurnipApiClient;
  final AuthenticationRepository _authenticationRepository;

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
}
