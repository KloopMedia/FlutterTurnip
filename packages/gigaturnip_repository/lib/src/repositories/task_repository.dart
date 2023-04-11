import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

abstract class TaskRepository extends GigaTurnipRepository<api.Task, Task> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  TaskRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  List<Task> parseData(List<api.Task> data) {
    return data.map(Task.fromApiModel).toList();
  }
}

class ClosedTaskRepository extends TaskRepository {
  ClosedTaskRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<api.Task>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserRelevantTasks(query: {
      'complete': true,
      'stage__chain__campaign': campaignId,
      ...?query,
    });
  }
}

class OpenTaskRepository extends TaskRepository {
  OpenTaskRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<api.Task>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserRelevantTasks(query: {
      'complete': false,
      'stage__chain__campaign': campaignId,
      ...?query,
    });
  }
}

class AvailableTaskRepository extends TaskRepository {
  AvailableTaskRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<api.Task>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserSelectableTasks(
      query: {
        'stage__chain__campaign': campaignId,
        ...?query,
      },
    );
  }

  Future<void> requestAssignment(int id) async {
    return _gigaTurnipApiClient.requestTask(id);
  }
}

class CreatableTaskRepository extends GigaTurnipRepository<api.TaskStage, TaskStage> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  CreatableTaskRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  Future<api.PaginationWrapper<api.TaskStage>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserRelevantTaskStages(
      query: {
        'chain__campaign': campaignId,
        ...?query,
      },
    );
  }

  @override
  List<TaskStage> parseData(List<api.TaskStage> data) {
    return data.map(TaskStage.fromApiModel).toList();
  }

  Future<int> createTask(int id) async {
    final response = await _gigaTurnipApiClient.createTaskFromStageId(id);
    return response.id;
  }
}