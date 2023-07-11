import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:local_database/local_database.dart' as db;

class CampaignDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<Campaign> fetchData(int id) async {
    try {
      final campaign = await _gigaTurnipApiClient.getCampaignById(id);
      return Campaign.fromApiModel(campaign, false);
    } catch (e) {
      print(e);
      final data = await db.LocalDatabase.getSingleCampaign(id);
      return Campaign.fromDB(data);
    }
  }

  Future<void> joinCampaign(int id) async {
    await _gigaTurnipApiClient.joinCampaign(id);
  }
}
