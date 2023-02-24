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

class SelectableTaskRepository extends TaskRepository {
  SelectableTaskRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<api.Task>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserSelectableTasks(
      query: {
        'stage__chain__campaign': campaignId,
        ...?query,
      },
    );
  }
}
