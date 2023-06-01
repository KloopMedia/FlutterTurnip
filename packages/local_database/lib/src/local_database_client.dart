import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

import 'models/models.dart';

class LocalDatabase {
  static final database = impl.connect();

  static Future<List<CampaignData>> getCampaigns() async {
    return await database.select(database.campaign).get();
  }

  static Future<int> insertCampaign(CampaignCompanion entity) async {
    return database.into(database.campaign).insert(entity, mode: InsertMode.insertOrIgnore);
  }
}
