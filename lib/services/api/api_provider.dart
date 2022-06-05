import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip/services/api/models/api_campaign.dart';
import 'package:gigaturnip/services/api/api_constants.dart';
import 'package:gigaturnip/services/api/api_exceptions.dart';
import 'package:gigaturnip/services/api/models/pagination_wrapper.dart';
import 'package:gigaturnip/services/auth/auth_provider.dart';
import 'package:gigaturnip/services/auth/auth_user.dart';

class ApiProvider {
  final AuthProvider provider;
  final Dio _dio;

  ApiProvider({required this.provider})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            receiveTimeout: 15000, // 15 seconds
            connectTimeout: 15000,
            sendTimeout: 15000,
          ),
        )..interceptors.add(ApiInterceptors(provider: provider));

  Future<List<ApiCampaign>> getCampaigns() async {
    try {
      Response response = await _dio.get(campaignsUrl);
      var data = PaginationWrapper.fromJson(response.data);
      List<ApiCampaign> campaigns = data.results.map((json) => ApiCampaign.fromJson(json)).toList();
      return campaigns;
    } on DioError catch (e) {
      print('DIO error: $e');
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

class ApiInterceptors extends Interceptor {
  final AuthProvider provider;

  ApiInterceptors({required this.provider});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await provider.getAccessToken();

    options.headers['Authorization'] = 'JWT $accessToken';

    return handler.next(options);
  }
}
