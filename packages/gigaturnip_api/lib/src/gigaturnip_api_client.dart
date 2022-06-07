import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_api/src/routes.dart';

class GigaTurnipApiClient {
  static const baseUrl = 'http://127.0.0.1:8000';

  final Dio _httpClient;

  GigaTurnipApiClient({Dio? httpClient})
      : _httpClient = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await _httpClient.get(campaignsRoute);
      var data = PaginationWrapper.fromJson(response.data);
      List<Campaign> campaigns = data.results.map((json) => Campaign.fromJson(json)).toList();
      return campaigns;
    } on DioError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
