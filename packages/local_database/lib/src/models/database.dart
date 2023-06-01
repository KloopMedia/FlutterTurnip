import 'package:drift/drift.dart';

import 'models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Campaign])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
