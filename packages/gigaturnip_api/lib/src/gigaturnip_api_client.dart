import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';

class GigaTurnipApiClient {
  static const baseUrl = 'https://journal-bb5e3.uc.r.appspot.com';

  //static const baseUrl = 'http://127.0.0.1:8000';

  final Dio _httpClient;

  GigaTurnipApiClient({Dio? httpClient})
      : _httpClient = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl));

  // Campaign methods
  Future<PaginationWrapper<Campaign>> getCampaigns({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(campaignsRoute, queryParameters: query);

      return PaginationWrapper<Campaign>.fromJson(
        response.data,
        (json) => Campaign.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Campaign> getCampaignById(int id) async {
    try {
      final response = await _httpClient.get('$campaignsRoute$id/');
      return Campaign.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> joinCampaign(int id) async {
    try {
      await _httpClient.post(campaignsRoute + id.toString() + joinCampaignActionRoute);
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // TaskStage methods
  Future<List<TaskStage>> getUserRelevantTaskStages({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(userRelevantTaskStageRoute, queryParameters: query);
      List<TaskStage> list = (response.data as List)
          .map((json) => TaskStage.fromJson(json as Map<String, dynamic>))
          .toList();

      return list;
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDynamicJsonTaskStage(
      {Map<String, dynamic>? query, required int id, Map<String, dynamic>? formData}) async {
    try {
      final jsonFormData = jsonEncode(formData);
      final response = await _httpClient.get(
        '$taskStagesRoute$id/load_schema_answers/?responses=$jsonFormData',
        queryParameters: query,
      );
      return response.data['schema'];
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  /// Request task creation and on success return task's id.
  Future<int> createTask({required int id}) async {
    try {
      final response = await _httpClient.post(
        taskStagesRoute + id.toString() + createTaskActionRoute,
      );
      final taskId = response.data['id'];
      if (taskId == null) {
        throw Exception("Task creation error: Id of created task can't be null");
      }
      return taskId;
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //Task methods
  Future<PaginationWrapper<Task>> getTasks({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(tasksRoute, queryParameters: query);

      return PaginationWrapper.fromJson(
        response.data,
        (json) => Task.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<PaginationWrapper<Task>> getUserSelectableTasks({Map<String, dynamic>? query}) async {
    try {
      print('getting data');
      final response = await _httpClient.get(
        selectableTasksRoute,
        queryParameters: query,
      );

      return PaginationWrapper.fromJson(
        response.data,
        (json) => Task.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Task> getTaskById({Map<String, dynamic>? query, required int id}) async {
    try {
      final response = await _httpClient.get(
        '$tasksRoute$id/',
        queryParameters: query,
      );

      return Task.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateTaskById({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    try {
      Map formData = {
        "responses": data['responses'],
        "complete": data['complete'],
      };
      final response = await _httpClient.patch('$tasksRoute$id/', data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print('CATCH: $e');
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Task>> getDisplayedPreviousTasks(
      {Map<String, dynamic>? query, required int id}) async {
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> requestTask({Map<String, dynamic>? query, required int id}) async {
    try {
      await _httpClient.get(
        tasksRoute + id.toString() + requestTaskActionRoute,
        queryParameters: query,
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
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
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Notification methods
  Future<PaginationWrapper<Notification>> getNotifications({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(notificationsRoute, queryParameters: query);
      return PaginationWrapper<Notification>.fromJson(
        response.data,
        (json) => Notification.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<PaginationWrapper<Notification>> getUserNotifications({Map<String, dynamic>? query}) async {
    try {
      final response = await _httpClient.get(userNotificationsRoute, queryParameters: query);
      return PaginationWrapper<Notification>.fromJson(
        response.data,
        (json) => Notification.fromJson(json as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> openNotification({Map<String, dynamic>? query, required int id}) async {
    try {
      await _httpClient.get(
        notificationsRoute + id.toString() + openNotificationActionRoute,
        queryParameters: query,
      );
    } on DioError catch (e) {
      print(e);
      throw GigaTurnipApiRequestException.fromDioError(e);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
