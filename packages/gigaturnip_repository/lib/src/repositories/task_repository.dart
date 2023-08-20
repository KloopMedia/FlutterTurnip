import 'dart:math';

import 'package:drift/drift.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:local_database/local_database.dart' as db;

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
    int countOnlineTasks;
    try {
      fetchAllTaskStages();
      final data = await _gigaTurnipApiClient.getUserRelevantTasks(query: {
        'stage__chain__campaign': campaignId,
        ...?query,
      });

      final parsedIn = parseData(data.results);
      countOnlineTasks = data.count;

      for (final item in parsedIn) {
        final entity = item.toDB();
        await db.LocalDatabase.insertTask(entity);
      }
    } catch (e) {
      countOnlineTasks = 0;
      print('ALL TASK REPOSITORY ERROR: $e');
    }

    final wrapper = await db.LocalDatabase.getTasks(campaignId, query: query);
    int countOfflineTasks = wrapper['count'] ?? 0;

    final results = wrapper['results'] as List<Map<String, dynamic>>;
    final parsedOut = results.map(Task.fromJson).toList();

    return api.PaginationWrapper(
        count: max(countOfflineTasks, countOnlineTasks), results: parsedOut);

    // return data.copyWith<Task>(results: parsed);
    // } catch (e) {
    //   print(e);
    //   final wrapper = await db.LocalDatabase.getTasks(campaignId, query: query);
    //   final results = wrapper['results'] as List<Map<String, dynamic>>;
    //   final parsed = results.map(Task.fromJson).toList();
    //   return api.PaginationWrapper(count: wrapper['count'], results: parsed);
    // }
  }

  void fetchAllTaskStages() async {
    try {
      final data = await _gigaTurnipApiClient.getAvailableTaskStages(
        query: {'chain__campaign': campaignId, 'limit': 100},
      );

      final parsed = data.results.map(TaskStageDetail.fromApiModel).toList();
      for (final item in parsed) {
        final entity = item.toDB();
        db.LocalDatabase.insertTaskStage(entity);
      }
    } catch (e) {
      print('FETCHING ALL TASK STAGES ERROR $e');
    }
  }
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

    try {
      final data = await _gigaTurnipApiClient.getUserRelevantTaskStages(
        query: _query,
      );
      final parsed = parseData(data.results);

      for (final item in parsed) {
        final entity = db.RelevantTaskStageCompanion.insert(
          id: Value(item.id),
          name: item.name,
          description: Value(item.description),
          campaign: item.campaign,
          chain: item.chain,
          availableTo: Value(item.availableTo),
          availableFrom: Value(item.availableFrom),
          stageType: Value(convertStageTypeToString(item.stageType)),
          openLimit: item.openLimit,
          totalLimit: item.totalLimit,
        );
        db.LocalDatabase.insertRelevantTaskStage(entity);
      }

      final filtered = _filterTasks(parsed);

      return data.copyWith<TaskStage>(results: filtered);
    } catch (e) {
      print("ERROR IN CREATABLE REPOSITORY: $e");
      final results = await db.LocalDatabase.getRelevantTaskStages(query: _query);
      final parsed = results.map(TaskStage.fromRelevant).toList();
      final filtered = _filterTasks(parsed);
      return api.PaginationWrapper(count: results.length, results: filtered);
    }
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

  Future<int> _countOpenedTasks(int stageId) async {
    final tasks =
        await db.LocalDatabase.getTasks(campaignId, query: {'stage': stageId, 'complete': false});
    return tasks['count'];
  }

  Future<int> _countTotalTasks(int stageId) async {
    final tasks = await db.LocalDatabase.getTasks(campaignId, query: {'stage': stageId});
    return tasks.length;
  }

  Future<int> createTask(int id) async {
    try {
      final response = await _gigaTurnipApiClient.createTaskFromStageId(id);
      final task = await _gigaTurnipApiClient.getTaskById(response.id);
      final parsed = TaskDetail.fromApiModel(task);
      db.LocalDatabase.insertTask(parsed.toDB());
      return response.id;
    } catch (e) {
      final cachedStage = await db.LocalDatabase.getSingleRelevantTaskStage(id);
      final stage = TaskStage.fromRelevant(cachedStage);
      final openedTasksCount = await _countOpenedTasks(id);
      final totalTaskCount = await _countTotalTasks(id);
      if (stage.totalLimit == 0 || totalTaskCount < stage.totalLimit) {
        if (stage.openLimit == 0 || openedTasksCount < stage.openLimit) {
          final task = Task.blank(stage, true);
          final cachedTask = task.toDB();
          final cachedId = await db.LocalDatabase.insertTask(cachedTask);
          return cachedId;
        } else {
          print('OPEN LIMIT EXCEEDED');
          throw TaskLimitException();
        }
      } else {
        print('TOTAL LIMIT EXCEEDED');
        throw TaskLimitException();
      }
    }
  }
}

class TaskLimitException implements Exception {
  final String error = 'Task limit exceeded.';

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
