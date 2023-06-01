import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:local_database/local_database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

MyDatabase connect() {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
  return MyDatabase(db);
}
