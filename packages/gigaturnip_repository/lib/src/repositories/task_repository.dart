import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

abstract class TaskRepository extends GigaTurnipRepository<Task> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  TaskRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Task> parseData(List<api.Task> data) {
    return data.map(Task.fromApiModel).toList();
  }
}

class AllTaskRepository extends TaskRepository {
  AllTaskRepository({
    required super.gigaTurnipApiClient,
    required super.campaignId,
    super.limit,
  });

  @override
  Future<api.PaginationWrapper<Task>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserRelevantTasks(query: {
      'stage__chain__campaign': campaignId,
      ...?query,
    });

    final parsedIn = parseData(data.results);
    return data.copyWith<Task>(results: parsedIn);
  }

// void fetchAllTaskStages() async {
//   try {
//     final data = await _gigaTurnipApiClient.getAvailableTaskStages(
//       query: {'chain__campaign': campaignId, 'limit': 200},
//     );
//
//     final parsed = data.results.map(TaskStageDetail.fromApiModel).toList();
//     for (final item in parsed) {
//       final entity = item.toDB();
//       db.LocalDatabase.insertTaskStage(entity);
//     }
//   } catch (e) {
//     print('FETCHING ALL TASK STAGES ERROR $e');
//   }
// }

  /// Send locally created tasks to remote and replace them.
// void syncRemoteData() async {
//   print('SYNC REMOTE');
//   final results = await db.LocalDatabase.getLocallyCreatedTasks();
//   for (var task in results) {
//     print(task['id']);
//     final data = {
//       'responses': task['responses'],
//       'complete': task['complete'],
//     };
//     try {
//       final response = await _gigaTurnipApiClient.createTaskFromStageId(
//         task['stage'],
//         data: data,
//       );
//       final newTask = TaskDetail.fromApiModel(response)
//           .toDB()
//           .copyWith(submittedOffline: task['submittedOffline']);
//       db.LocalDatabase.insertTask(newTask);
//       db.LocalDatabase.deleteTask(task['id']);
//     } catch (e) {
//       print('SYNC FAILED $e');
//     }
//   }
// }
}

class ClosedTaskRepository extends TaskRepository {
  ClosedTaskRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<Task>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserRelevantTasks(query: {
      'complete': true,
      'stage__chain__campaign': campaignId,
      ...?query,
    });
    return data.copyWith<Task>(results: parseData(data.results));
  }
}

class OpenTaskRepository extends TaskRepository {
  OpenTaskRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<Task>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserRelevantTasks(query: {
      'complete': false,
      'stage__chain__campaign': campaignId,
      ...?query,
    });
    return data.copyWith<Task>(results: parseData(data.results));
  }
}

class AvailableTaskRepository extends TaskRepository {
  final int stageId;

  AvailableTaskRepository({
    required super.gigaTurnipApiClient,
    required super.campaignId,
    required this.stageId,
  });

  Future<PageData<Task>> fetchWithPostAndParseData(int page, Map<String, dynamic> body,
      [Map<String, dynamic>? query]) async {
    final paginationQuery = {
      'limit': limit,
      'offset': calculateOffset(page),
      ...?query,
    };

    final response = await _gigaTurnipApiClient.postUserSelectableTasks(
      body,
      query: {
        'stage': stageId,
        'stage__chain__campaign': campaignId,
        ...paginationQuery,
      },
    );
    final data = response.copyWith<Task>(results: parseData(response.results));

    return PageData(
      data: data.results,
      currentPage: page,
      total: calculateTotalPage(data.count),
      count: data.count,
    );
  }

  @override
  Future<api.PaginationWrapper<Task>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserSelectableTasks(
      query: {
        'stage': stageId,
        'stage__chain__campaign': campaignId,
        ...?query,
      },
    );
    return data.copyWith<Task>(results: parseData(data.results));
  }

  Future<void> requestAssignment(int id) async {
    return _gigaTurnipApiClient.requestTask(id);
  }
}

class CreatableTaskRepository extends GigaTurnipRepository<TaskStage> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;
  final StageType stageType;

  CreatableTaskRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
    required this.stageType,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  Future<api.PaginationWrapper<TaskStage>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final type = convertStageTypeToString(stageType);
    final _query = {
      'chain__campaign': campaignId,
      'stage_type': type,
      ...?query,
    };

    final data = await _gigaTurnipApiClient.getUserRelevantTaskStages(
      query: _query,
    );
    final parsed = parseData(data.results);

    final filtered = _filterTasks(parsed);

    return data.copyWith<TaskStage>(results: filtered);
  }

  List<TaskStage> parseData(List<api.TaskStage> data) {
    return data.map(TaskStage.fromApiModel).toList();
  }

  List<TaskStage> _filterTasks(List<TaskStage> data) {
    final now = DateTime.now();

    final creatable = data.where((item) {
      final startDate = item.availableFrom;
      final endDate = item.availableTo;

      if (startDate != null && endDate != null) {
        if (startDate.isBefore(now) && endDate.isAfter(now)) {
          return true;
        }
        return false;
      }

      return true;
    }).toList();

    return creatable;
  }

  Future<int> createTask(int id, {bool fastTrack = false}) async {
    final task = await _gigaTurnipApiClient.createTaskFromStageId(id, data: {
      "fast_track": fastTrack,
    });
    return task.id;
  }
}

class TaskLimitException implements Exception {
  final String error = 'You created required amount of this form, now go to the next form.';

  @override
  String toString() {
    return error;
  }
}

class SelectableTaskStageRepository extends GigaTurnipRepository<TaskStage> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  SelectableTaskStageRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  Future<api.PaginationWrapper<TaskStage>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getSelectableTaskStages(
      query: {
        'chain__campaign': campaignId,
        ...?query,
      },
    );
    return data.copyWith<TaskStage>(results: parseData(data.results));
  }

  List<TaskStage> parseData(List<api.TaskStage> data) {
    return data.map(TaskStage.fromApiModel).toList();
  }
}
