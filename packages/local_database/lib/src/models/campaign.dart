import 'package:drift/drift.dart';

class Campaign extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  TextColumn get descriptor => text().nullable()();

  TextColumn get logo => text()();

  BoolColumn get joined => boolean()();
}
