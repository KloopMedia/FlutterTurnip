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
      final task = await _gigaTurnipApiClient.getTaskById(id);
      return TaskDetail.fromApiModel(task);
    } catch (e) {
      final data = await db.LocalDatabase.getSingleTask(id);
      final stage = await db.LocalDatabase.getSingleTaskStage(data.stage);
      return TaskDetail.fromDB(data, stage);
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
    try {
      return _gigaTurnipApiClient.saveTaskById(id, data);
    } catch (e) {
      final task = await db.LocalDatabase.getSingleTask(id);
      db.LocalDatabase.updateTask(
        task.copyWith(
          responses: data['responses'],
          complete: data['complete'],
        ),
      );
      return TaskResponse(id: id, nextDirectId: null);
    }
  }

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
}
