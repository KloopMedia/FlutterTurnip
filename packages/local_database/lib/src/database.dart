import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'models/models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Campaign, TaskStage, Task, RelevantTaskStage])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(campaign, campaign.smsCompleteTaskAllow);
          await m.addColumn(campaign, campaign.smsPhone);
        }
        if (from < 4) {
          await m.addColumn(taskStage, taskStage.availableTo);
          await m.addColumn(taskStage, taskStage.availableFrom);
          await m.createTable(relevantTaskStage);
        }
        if (from < 5) {
          await m.addColumn(taskStage, taskStage.stageType);
        }
        if (from < 6) {
          await m.addColumn(relevantTaskStage, relevantTaskStage.stageType);
        }
        if (from < 7) {
          await m.addColumn(relevantTaskStage, relevantTaskStage.totalLimit);
          await m.addColumn(relevantTaskStage, relevantTaskStage.openLimit);
        }
        if (from < 8) {
          await m.addColumn(taskStage, taskStage.totalLimit);
          await m.addColumn(taskStage, taskStage.openLimit);
        }
        if (from < 9) {
          await m.addColumn(task, task.createdOffline);
        }
        if (from < 10) {
          await m.addColumn(task, task.updatedAt);
        }
      },
    );
  }

  @override
  int get schemaVersion => 10;
}
