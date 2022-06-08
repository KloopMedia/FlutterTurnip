import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gigaturnip_api/src/helpers/routes.dart';
import 'package:gigaturnip_api/src/models/models.dart';

class GigaTurnipApiClient {
  static const baseUrl = 'http://127.0.0.1:8000';

  final Dio _httpClient;

  GigaTurnipApiClient({Dio? httpClient})
      : _httpClient = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl));


  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await _httpClient.get(campaignsRoute);
      final data = PaginationWrapper.fromJson(response.data);
      List<Campaign> campaigns = data.results.map((json) => Campaign.fromJson(json)).toList();
      return campaigns;
    } on DioError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<List<Task>> getTasks({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(tasksRoute);
      print(response);
      final data = PaginationWrapper.fromJson(response.data);
      List<Task> tasks = data.results.map((json) => Task.fromJson(json)).toList();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }
}
