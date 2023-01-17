import 'dart:async';

import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

import '../gigaturnip_repository.dart';
import 'utilities/utilities.dart';

enum CampaignsActions { listUserCampaigns, listSelectableCampaigns }

class CampaignRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignRepository(this._gigaTurnipApiClient);

  List<Campaign> _userCampaigns = [];
  List<Campaign> _selectableCampaigns = [];

  final Duration _cacheValidDuration = const Duration(minutes: 30);
  DateTime _campaignLastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);

  Future<List<Campaign>> getUserCampaigns([forceRefresh = false]) async {
    bool shouldRefresh = shouldRefreshFromApi(
      _cacheValidDuration,
      _campaignLastFetchTime,
      forceRefresh,
    );

    if (shouldRefresh) {
      final userCampaignsData = await _gigaTurnipApiClient.getUserCampaigns();
      _userCampaigns = userCampaignsData.map(Campaign.fromApiModel).toList();
      _campaignLastFetchTime = DateTime.now();
    }

    return _userCampaigns;
  }

  Future<List<Campaign>> getSelectableCampaigns([forceRefresh = false]) async {
    bool shouldRefresh = shouldRefreshFromApi(
      _cacheValidDuration,
      _campaignLastFetchTime,
      forceRefresh,
    );

    if (shouldRefresh) {
      final selectableCampaignsData = await _gigaTurnipApiClient.getSelectableCampaigns();
      _selectableCampaigns = selectableCampaignsData.map(Campaign.fromApiModel).toList();
      _campaignLastFetchTime = DateTime.now();
    }

    return _selectableCampaigns;
  }

  Future<Campaign> getCampaignById(int id) async {
    final campaign = await _gigaTurnipApiClient.getCampaignById(id);
    return Campaign.fromApiModel(campaign);
  }

  Future<void> joinCampaign(int id) async {
    _gigaTurnipApiClient.joinCampaign(id);
  }
}
