import 'dart:async';

import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

import '../gigaturnip_repository.dart';

enum CampaignsActions { listUserCampaigns, listSelectableCampaigns }

class CampaignRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignRepository(this._gigaTurnipApiClient);

  Future<List<Campaign>> getUserCampaigns() async {
    final userCampaignsData = await _gigaTurnipApiClient.getUserCampaigns();
    return userCampaignsData
        .map((api.Campaign campaign) => Campaign.fromApiModel(campaign, false))
        .toList();
  }

  Future<List<Campaign>> getSelectableCampaigns() async {
    final selectableCampaignsData = await _gigaTurnipApiClient.getSelectableCampaigns();
    return selectableCampaignsData
        .map((api.Campaign campaign) => Campaign.fromApiModel(campaign, true))
        .toList();
  }

  Future<Campaign> getCampaignById(int id) async {
    final campaign = await _gigaTurnipApiClient.getCampaignById(id);
    return Campaign.fromApiModel(campaign, false);
  }

  Future<void> joinCampaign(int id) async {
    await _gigaTurnipApiClient.joinCampaign(id);
  }
}
