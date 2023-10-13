import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TaskDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  TaskDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<TaskDetail> fetchData(int id) async {
    final task = await _gigaTurnipApiClient.getTaskById(id);
    return TaskDetail.fromApiModel(task);
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
    return _gigaTurnipApiClient.saveTaskById(id, data);
  }

  Future<TaskResponse> submitTask(TaskDetail task) async {
    final id = task.id;
    final data = {'responses': task.responses, 'complete': true};

    final response = await _gigaTurnipApiClient.saveTaskById(id, data);
    return response;
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

  Future<void> releaseTask(int id) async {
    await _gigaTurnipApiClient.releaseTask(id);
  }

  Future<int> openPreviousTask(int id) async {
    final response = await _gigaTurnipApiClient.openPreviousTask(id);
    return response.data['id'] as int;
  }
}
