import 'dart:async';

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

  Future<List<Campaign>> getUserCampaigns({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(userCampaignsRoute, queryParameters: query);
      List<Campaign> list = (response.data as List)
          .map((json) => Campaign.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Campaign>> getSelectableCampaigns({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(selectableCampaignsRoute, queryParameters: query);
      List<Campaign> list = (response.data as List)
          .map((json) => Campaign.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

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

  Future<List<Task>> getUserSelectableTasks({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(
        selectableTasksRoute,
        queryParameters: query,
      );
      List<Task> list = (response.data as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getUserRelevantTasks({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(
        relevantTasksRoute,
        queryParameters: query,
      );
      List<Task> list = (response.data as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> getTaskById({Map<String, dynamic>? query, required int id}) async {
    try {
      final response = await _httpClient.get(
        tasksRoute + id.toString(),
        queryParameters: query,
      );

      return Task.fromJson(response.data);
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getIntegratedTasks({Map<String, dynamic>? query, required int id}) async {
    try {
      final response = await _httpClient.get(
        tasksRoute + id.toString() + integratedTasksActionRoute,
        queryParameters: query,
      );
      List<Task> list = (response.data as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getDisplayedPreviousTasks({Map<String, dynamic>? query, required int id}) async {
    try {
      final response = await _httpClient.get(
        tasksRoute + id.toString() + displayedPreviousTasksActionRoute,
        queryParameters: query,
      );
      List<Task> list = (response.data as List)
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> openPreviousTask({Map<String, dynamic>? query, required int id}) async {
    try {
      final response = await _httpClient.get(
        tasksRoute + id.toString() + openPreviousTaskActionRoute,
        queryParameters: query,
      );

      return Task.fromJson(response.data);
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> releaseTask({Map<String, dynamic>? query, required int id}) async {
    try {
      await _httpClient.get(
        tasksRoute + id.toString() + releaseTaskActionRoute,
        queryParameters: query,
      );
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> requestTask({Map<String, dynamic>? query, required int id}) async {
    try {
      final response = await _httpClient.get(
        tasksRoute + id.toString() + requestTaskActionRoute,
        queryParameters: query,
      );

      return Task.fromJson(response.data);
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> triggerTaskWebhook({Map<String, dynamic>? query, required int id}) async {
    try {
      await _httpClient.get(
        tasksRoute + id.toString() + triggerWebhookActionRoute,
        queryParameters: query,
      );
    } on DioError catch (e) {
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reopenTask({Map<String, dynamic>? query, required int id}) async {
    try {
      await _httpClient.get(
        tasksRoute + id.toString() + reopenTaskActionRoute,
        queryParameters: query,
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

  Future<List<Notification>> getUserNotifications({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(userNotificationsRoute, queryParameters: query);
      List<Notification> list = (response.data as List)
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