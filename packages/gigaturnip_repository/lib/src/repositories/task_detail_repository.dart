import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:local_database/local_database.dart' as db;

class TaskDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  TaskDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<TaskDetail> fetchData(int id) async {
    try {
      try {
        final task = await _gigaTurnipApiClient.getTaskById(id);
        return TaskDetail.fromApiModel(task);
      } catch (e) {
        final data = await db.LocalDatabase.getSingleTask(id);
        final stage = await db.LocalDatabase.getSingleTaskStage(data.stage);
        return TaskDetail.fromDB(data, stage);
      }
    } catch (e) {
      final task = await _gigaTurnipApiClient.getTaskById(id);
      return TaskDetail.fromApiModel(task);
    }
  }

  Future<List<TaskDetail>> fetchPreviousTaskData(int id) async {
    try {
      final tasks = await _gigaTurnipApiClient.getDisplayedPreviousTasks(id);
      return tasks.results.map(TaskDetail.fromApiModel).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<TaskResponse> saveData(int id, Map<String, dynamic> data) async {
    final task = await db.LocalDatabase.getSingleTask(id);
    db.LocalDatabase.updateTask(
      task.copyWith(
        responses: Value(jsonEncode(data['responses'])),
        complete: data['complete'],
      ),
    );
    try {
      return _gigaTurnipApiClient.saveTaskById(id, data);
    } catch (e) {
      return TaskResponse(id: id, nextDirectId: null, notifications: null);
    }
  }

  Future<TaskResponse> submitTask(TaskDetail task) async {
    final id = task.id;
    final data = {'responses': task.responses, 'complete': true};
    db.TaskData cachedTask;
    try {
      cachedTask = await db.LocalDatabase.getSingleTask(id);
    } catch (e) {
      final cachedId = await db.LocalDatabase.insertTask(task.toDB());
      cachedTask = await db.LocalDatabase.getSingleTask(cachedId);
    }
    print(cachedTask.createdOffline);
    try {
      if (cachedTask.createdOffline) {
        final newTask = await _gigaTurnipApiClient.createTaskFromStageId(
          cachedTask.stage,
          data: {'responses': data['responses']},
        );
        final response = await _gigaTurnipApiClient.saveTaskById(newTask.id, {'complete': true});
        db.LocalDatabase.deleteTask(cachedTask.id);
        final parsed = TaskDetail.fromApiModel(newTask);
        await db.LocalDatabase.insertTask(parsed.copyWith(complete: true).toDB());
        return response;
      } else {
        final response = await _gigaTurnipApiClient.saveTaskById(id, data);
        final copyTask = cachedTask.copyWith(
          responses: Value(jsonEncode(data['responses'])),
          complete: true,
          submittedOffline: false,
        );
        db.LocalDatabase.updateTask(copyTask);
        return response;
      }
    } on DioException catch (e) {
      print(e);
      final isNotFoundOrAuthorised = e.response?.statusCode != null &&
          (e.response?.statusCode == 403 || e.response?.statusCode == 404);

      if (isNotFoundOrAuthorised && cachedTask.createdOffline) {
        print("CREATED NEW TASK");
        final newTask = await _gigaTurnipApiClient.createTaskFromStageId(
          cachedTask.stage,
          data: {'responses': data['responses']},
        );
        final response = await _gigaTurnipApiClient.saveTaskById(newTask.id, {'complete': true});

        db.LocalDatabase.deleteTask(cachedTask.id);
        final parsed = TaskDetail.fromApiModel(newTask);
        await db.LocalDatabase.insertTask(parsed.copyWith(complete: true).toDB());
        return response;
      } else {
        final isNotAuthorised = e.response?.statusCode != null && e.response?.statusCode == 403;
        if (isNotAuthorised) {
          final _task = await _gigaTurnipApiClient.getTaskById(id);
          final parsedTask = TaskDetail.fromApiModel(_task).toDB();
          db.LocalDatabase.deleteTask(cachedTask.id);
          await db.LocalDatabase.insertTask(parsedTask);
          print('GET REMOTE AND ADD TASK');
        } else {
          final copyTask = cachedTask.copyWith(
            responses: Value(jsonEncode(data['responses'])),
            complete: false,
            submittedOffline: true,
          );
          db.LocalDatabase.updateTask(copyTask);
          print('LOCAL TASK UPDATED ${copyTask.id}');
        }
        return api.TaskResponse(id: id, nextDirectId: null, notifications: null);
      }
    }
  }

  // Future<TaskResponse> submitTask(int id, Map<String, dynamic> data) async {
  //   int? newId;
  //   int? newCachedId;
  //   final task = await db.LocalDatabase.getSingleTask(id);
  //   if (task.createdOffline) {
  //     try {
  //       final response = await _gigaTurnipApiClient
  //           .createTaskFromStageId(task.stage, data: {'responses': data['responses']});
  //       newId = response.id;
  //       db.LocalDatabase.deleteTask(task.id);
  //       final parsed = TaskDetail.fromApiModel(response)..copyWith(complete: data['complete']);
  //       final newLocalTask = parsed.toDB();
  //       newCachedId = await db.LocalDatabase.insertTask(newLocalTask);
  //     } catch (e) {
  //       newId = id;
  //       db.LocalDatabase.updateTask(
  //         task.copyWith(
  //           responses: Value(jsonEncode(data['responses'])),
  //           complete: data['complete'],
  //           submittedOffline: true,
  //         ),
  //       );
  //     }
  //   } else {
  //     newId = id;
  //     db.LocalDatabase.updateTask(
  //       task.copyWith(
  //         responses: Value(jsonEncode(data['responses'])),
  //         complete: data['complete'],
  //       ),
  //     );
  //   }
  //
  //   try {
  //     final response = await _gigaTurnipApiClient.saveTaskById(newId, data);
  //
  //     if (response.nextDirectId == response.id && newCachedId != null) {
  //       final task = await db.LocalDatabase.getSingleTask(newCachedId);
  //
  //       db.LocalDatabase.updateTask(
  //         task.copyWith(
  //           responses: Value(jsonEncode(data['responses'])),
  //           complete: false,
  //           submittedOffline: true,
  //         ),
  //       );
  //
  //       return api.TaskResponse(id: newId, nextDirectId: newId);
  //     }
  //
  //     return response;
  //   } catch (e) {
  //     newId = id;
  //     db.LocalDatabase.updateTask(
  //       task.copyWith(
  //         responses: Value(jsonEncode(data['responses'])),
  //         complete: data['complete'],
  //         submittedOffline: true,
  //       ),
  //     );
  //     rethrow;
  //   }
  // }

  Future<Map<String, dynamic>> triggerWebhook(int id) async {
    try {
      final response = await _gigaTurnipApiClient.triggerTaskWebhook(id);
      return response.responses;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> getDynamicSchema({
    required int taskId,
    required int stageId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final dynamicSchema = await _gigaTurnipApiClient.getDynamicSchema(
        stageId,
        query: {
          'current_task': taskId,
          'responses': data,
        },
      );
      return dynamicSchema.schema;
    } catch (e) {
      return {};
    }
  }

  Future<void> releaseTask(int id) async {
    await _gigaTurnipApiClient.releaseTask(id);
  }

  Future<int> openPreviousTask(int id) async {
    final response = await _gigaTurnipApiClient.openPreviousTask(id);
    return response.data['id'] as int;
  }
}
