import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class CampaignDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<Campaign> fetchData(int id) async {
    final campaign = await _gigaTurnipApiClient.getCampaignById(id);
    return Campaign.fromApiModel(campaign, false);
  }

  Future<void> joinCampaign(int id) async {
    await _gigaTurnipApiClient.joinCampaign(id);
  }
}
