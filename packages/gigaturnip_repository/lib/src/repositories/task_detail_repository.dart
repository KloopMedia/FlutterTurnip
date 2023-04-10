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
    final tasks = await _gigaTurnipApiClient.getDisplayedPreviousTasks(id);
    return tasks.results.map(TaskDetail.fromApiModel).toList();
  }

  Future<TaskResponse> saveData(int id, Map<String, dynamic> data) {
    return _gigaTurnipApiClient.saveTaskById(id, data);
  }

  Future<Map<String, dynamic>> triggerWebhook(int id) async {
    final response = await _gigaTurnipApiClient.triggerTaskWebhook(id);
    return response.responses;
  }

  Future<Map<String, dynamic>> getDynamicSchema({
    required int taskId,
    required int stageId,
    required Map<String, dynamic> data,
  }) async {
    final dynamicSchema = await _gigaTurnipApiClient.getDynamicSchema(
      stageId,
      query: {
        'current_task': taskId,
        'responses': data,
      },
    );
    return dynamicSchema.schema;
  }
}