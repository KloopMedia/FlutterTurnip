import 'package:drift/drift.dart';

import 'database.dart';

class LocalDatabase {
  static final database = AppDatabase();

  static Future<List<CampaignData>> getCampaigns(bool joined) async {
    return (database.select(database.campaign)..where((tbl) => tbl.joined.equals(joined))).get();
  }

  static Future<CampaignData> getSingleCampaign(int id) async {
    return (database.select(database.campaign)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  static Future<int> insertCampaign(CampaignCompanion entity) async {
    return database.into(database.campaign).insert(entity, mode: InsertMode.insertOrReplace);
  }

  static Future<List<TaskStageData>> getTaskStages() async {
    return database.select(database.taskStage).get();
  }

  static Future<List<RelevantTaskStageData>> getRelevantTaskStages() async {
    return database.select(database.relevantTaskStage).get();
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

  static Future<int> insertRelevantTaskStage(TaskStageCompanion entity) async {
    final newEntity = RelevantTaskStageCompanion(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      campaign: entity.campaign,
      chain: entity.chain,
      availableTo: entity.availableTo,
      availableFrom: entity.availableFrom,
    );
    final insert = await database
        .into(database.relevantTaskStage)
        .insertReturning(newEntity, mode: InsertMode.insertOrReplace);
    return insert.id;
  }

  static void updateTask(TaskData data) {
    database.update(database.task)
      ..where((tbl) => tbl.id.equals(data.id))
      ..write(data);
  }

  static Future<Map<String, dynamic>> getTasks(int campaign, {Map<String, dynamic>? query}) async {
    final limit = query?['limit'] ?? 10;
    final offset = query?['offset'];
    final bool? completed = query?['complete'];
    final bool? reopened = query?['reopened'];

    final dbQuery = database.select(database.task).join([
      leftOuterJoin(database.taskStage, database.taskStage.id.equalsExp(database.task.stage)),
    ]);

    dbQuery.where(database.task.campaign.equals(campaign));
    if (completed != null) dbQuery.where(database.task.complete.equals(completed));
    if (reopened != null) dbQuery.where(database.task.reopened.equals(reopened));

    dbQuery.limit(limit, offset: offset);

    final rows = await dbQuery.get();

    final List<Map<String, dynamic>> parsed = [];
    for (var row in rows) {
      final task = row.readTable(database.task);
      final stage = row.readTableOrNull(database.taskStage);

      if (stage != null) {
        final jsonTask = task.toJson(
            serializer: const ValueSerializer.defaults(serializeDateTimeValuesAsString: true));
        final jsonStage = stage.toJson(
            serializer: const ValueSerializer.defaults(serializeDateTimeValuesAsString: true));

        jsonTask['stage'] = jsonStage;

        parsed.add(jsonTask);
      }
    }

    Expression<int> countTasks = database.task.id.count();

    final newQuery = database.select(database.task).join([
      leftOuterJoin(database.taskStage, database.taskStage.id.equalsExp(database.task.stage)),
    ]);

    newQuery.where(database.task.campaign.equals(campaign));

    if (completed != null) newQuery.where(database.task.complete.equals(completed));
    if (reopened != null) dbQuery.where(database.task.reopened.equals(reopened));

    newQuery.addColumns([countTasks]);
    final row = await newQuery.getSingle();
    final count = row.read(countTasks) ?? 0;

    return {'count': count, 'results': parsed};
  }

  static Future<int> insertTask(TaskCompanion entity) {
    return database.into(database.task).insert(entity, mode: InsertMode.insertOrIgnore);
  }
}
