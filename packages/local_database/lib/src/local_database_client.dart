import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

import 'models/models.dart';

class LocalDatabase {
  static final database = impl.connect();

  static Future<List<CampaignData>> getCampaigns() async {
    return database.select(database.campaign).get();
  }

  static Future<int> insertCampaign(CampaignCompanion entity) async {
    return database.into(database.campaign).insert(entity, mode: InsertMode.insertOrIgnore);
  }

  static Future<List<TaskStageData>> getTaskStages() async {
    return database.select(database.taskStage).get();
  }

  static Future<TaskStageData> getSingleTaskStage(int id) async {
    return (database.select(database.taskStage)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  static Future<int> insertTaskStage(TaskStageCompanion entity) {
    return database.into(database.taskStage).insert(entity, mode: InsertMode.insertOrIgnore);
  }

  static Future<List<TaskData>> getTasks() async {
    return database.select(database.task).get();
  }

  static Future<int> insertTask(TaskCompanion entity) {
    return database.into(database.task).insert(entity, mode: InsertMode.insertOrIgnore);
  }
}
