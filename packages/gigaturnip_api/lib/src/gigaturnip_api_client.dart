import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gigaturnip_api/src/helpers/exceptions.dart';
import 'package:gigaturnip_api/src/helpers/routes.dart';
import 'package:gigaturnip_api/src/models/models.dart';

class GigaTurnipApiClient {
  static const baseUrl = 'http://127.0.0.1:8000';

  final Dio _httpClient;

  GigaTurnipApiClient({Dio? httpClient})
      : _httpClient = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl));

  Future<PaginationWrapper<Campaign>> getCampaigns() async {
    try {
      final response = await _httpClient.get(campaignsRoute);
      return PaginationWrapper<Campaign>.fromJson(
        response.data,
        (json) => Campaign.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginationWrapper<Task>> getTasks({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(tasksRoute);
      return PaginationWrapper.fromJson(
        response.data,
        (json) => Task.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
