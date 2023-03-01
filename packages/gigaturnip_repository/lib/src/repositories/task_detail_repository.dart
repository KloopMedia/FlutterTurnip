import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TaskDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  TaskDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<Task> fetchData(int id) async {
    final task = await _gigaTurnipApiClient.getTaskById(id);
    return Task.fromApiModel(task);
  }

  Future<void> saveData(int id, Map<String, dynamic> data) {
    return _gigaTurnipApiClient.saveTaskById(id, data);
  }

  Future<void> triggerWebhook(int id) {
    return _gigaTurnipApiClient.triggerTaskWebhook(id);
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
