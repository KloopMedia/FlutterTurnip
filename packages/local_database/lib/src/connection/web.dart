import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: 'gigaturnip',
      sqlite3Uri: Uri.parse('/FlutterTurnip/sqlite3.wasm'),
      driftWorkerUri: Uri.parse('/FlutterTurnip/drift_worker.js'),
    );

    if (db.missingFeatures.isNotEmpty) {
      debugPrint('Using ${db.chosenImplementation} due to unsupported '
          'browser features: ${db.missingFeatures}');
    }

    return db.resolvedExecutor;
  }));
}

Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  // Unfortunately, validating database schemas only works for native platforms
  // right now.
  // As we also have migration tests (see the `Testing migrations` section in
  // the readme of this example), this is not a huge issue.
}
