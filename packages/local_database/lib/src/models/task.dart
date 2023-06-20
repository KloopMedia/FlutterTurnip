import 'package:drift/drift.dart';
import 'package:local_database/src/models/task_stage.dart';

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  BoolColumn get complete => boolean()();

  BoolColumn get reopened => boolean()();

  IntColumn get stage => integer().references(TaskStage, #id)();

  TextColumn get responses => text().nullable()();

  TextColumn get jsonSchema => text().nullable()();

  TextColumn get uiSchema => text().nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();
}
