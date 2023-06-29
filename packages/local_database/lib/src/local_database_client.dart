import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart' as repo;

import 'database.dart';

class LocalDatabase {
  static final database = AppDatabase();

  static Future<List<CampaignData>> getCampaigns() async {
    return database.select(database.campaign).get();
  }

  static Future<int> insertCampaign(CampaignCompanion entity) async {
    return database.into(database.campaign).insert(entity, mode: InsertMode.insertOrIgnore);
  }

  static Future<List<TaskStageData>> getTaskStages() async {
    return database.select(database.taskStage).get();
  }

  static Future<TaskData> getSingleTask(int id) async {
    return (database.select(database.task)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  static Future<TaskStageData> getSingleTaskStage(int id) async {
    return (database.select(database.taskStage)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  static Future<int> insertTaskStage(TaskStageCompanion entity) async {
    final insert = await database
        .into(database.taskStage)
        .insertReturning(entity, mode: InsertMode.insertOrReplace);
    return insert.id;
  }

  static void updateTask(TaskData data) {
    database.update(database.task)
      ..where((tbl) => tbl.id.equals(data.id))
      ..write(data);
  }

  static Future<List<repo.Task>> getTasks(int campaign) async {
    final query = database.select(database.task).join([
      leftOuterJoin(database.taskStage, database.taskStage.id.equalsExp(database.task.stage)),
    ]);

    query.where(database.task.campaign.equals(campaign));

    final rows = await query.get();

    final List<repo.Task> parsed = [];
    for (var row in rows) {
      final task = row.readTable(database.task);
      final stage = row.readTableOrNull(database.taskStage);

      if (stage != null) {
        final taskStage = repo.TaskStage(
          id: stage.id,
          name: stage.name,
          description: stage.description,
          chain: stage.chain,
          campaign: stage.campaign,
          cardJsonSchema: jsonDecode(stage.cardJsonSchema ?? "{}"),
          cardUiSchema: jsonDecode(stage.cardUiSchema ?? "{}"),
        );

        final parsedTask = repo.Task(
          id: task.id,
          name: task.name,
          responses: jsonDecode(task.responses ?? "{}"),
          complete: task.complete,
          reopened: task.reopened,
          createdAt: task.createdAt,
          cardJsonSchema: jsonDecode(stage.cardJsonSchema ?? "{}"),
          cardUiSchema: jsonDecode(stage.cardUiSchema ?? "{}"),
          stage: taskStage,
        );

        parsed.add(parsedTask);
      }
    }

    return parsed;
  }

  static Future<int> insertTask(TaskCompanion entity) {
    return database.into(database.task).insert(entity, mode: InsertMode.insertOrIgnore);
  }
}
