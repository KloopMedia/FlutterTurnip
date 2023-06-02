import 'package:drift/drift.dart';

import 'models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Campaign, TaskStage, Task])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }

  @override
  int get schemaVersion => 2;
}
