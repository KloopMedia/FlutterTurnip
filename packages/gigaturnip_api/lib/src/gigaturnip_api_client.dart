import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';


class GigaTurnipApiClient {
  static const baseUrl = 'http://127.0.0.1:8000';

  final Dio _httpClient;

  GigaTurnipApiClient({Dio? httpClient})
      : _httpClient = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl));


  //Campaign
  Future<PaginationWrapper<Campaign>> getCampaigns({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(campaignsRoute, queryParameters: query);
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

  Future<List<Campaign>> getListUserCampaigns({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(listUserCampaignsRoute, queryParameters: query);
      List<Campaign> list = (json.decode(response.data) as List)
          .map((json) => Campaign.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Campaign>> getListUserSelectableCampaigns({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(listUserSelectableCampaignsRoute, queryParameters: query);
      List<Campaign> list = (json.decode(response.data) as List)
          .map((json) => Campaign.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }


  // TODO: Add methods
  //Tasks
  Future<PaginationWrapper<Task>> getTasks({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(tasksRoute, queryParameters: query);
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

  Future<List<Task>> getUserSelectable({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(userSelectableRoute, queryParameters: query);
      List<Task> list = (json.decode(response.data) as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getUserRelevant({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(userRelevantRoute, queryParameters: query);
      List<Task> list = (json.decode(response.data) as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginationWrapper<Task>> getTasksById({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id, queryParameters: query);
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

  Future<PaginationWrapper<Task>> getIntegratedTasks({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id + 'get_integrated_tasks', queryParameters: query);
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

  Future<List<Task>> listDisplayedPrevious({Map<String, dynamic>? query, id}) async {
    try {
      final response = await _httpClient.get(tasksRoute + id + 'list_displayed_previous', queryParameters: query);
      List<Task> list = (json.decode(response.data) as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginationWrapper<Task>> openPrevious({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id + 'open_previous', queryParameters: query);
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

  Future<PaginationWrapper<Task>> releaseAssignment({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id + 'release_assignment', queryParameters: query);
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

  Future<PaginationWrapper<Task>> requestAssignment({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id + 'request_assignment', queryParameters: query);
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

  Future<PaginationWrapper<Task>> triggerWebhook({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id + 'trigger_webhook', queryParameters: query);
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

  Future<PaginationWrapper<Task>> uncomplete({Map<String, dynamic>? query, id}) async {
    try {

      final response = await _httpClient.get(tasksRoute + id + 'uncomplete', queryParameters: query);
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


  // Notifications
  Future<PaginationWrapper<Notification>> getNotifications({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(notificationsRoute, queryParameters: query);
      return PaginationWrapper<Notification>.fromJson(
        response.data,
            (json) => Notification.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Notification>> getListUserNotifications({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(listUserNotificationsRoute, queryParameters: query);
      List<Notification> list = (json.decode(response.data) as List)
          .map((json) => Notification.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }


}
