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
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(taskStage, taskStage.availableTo);
          await m.addColumn(taskStage, taskStage.availableFrom);
          await m.createTable(relevantTaskStage);
        }
      },
    );
  }

  @override
  int get schemaVersion => 4;
}
