import 'package:drift/drift.dart';

class TaskStage extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  IntColumn get chain => integer()();
  IntColumn get campaign => integer()();

  TextColumn get richText => text().nullable()();

  TextColumn get cardJsonSchema => text().nullable()();
  TextColumn get cardUiSchema => text().nullable()();

  TextColumn get jsonSchema => text().nullable()();
  TextColumn get uiSchema => text().nullable()();
}
