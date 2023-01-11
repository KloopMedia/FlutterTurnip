import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart'
    hide Campaign, Task, Chain, TaskStage, Notification;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import 'interceptor.dart';
import 'utilities/utilities.dart';

enum CampaignsActions { listUserCampaigns, listSelectableCampaigns }

class CampaignRepository {
  late final GigaTurnipApiClient _gigaTurnipApiClient;

  List<Campaign> _userCampaigns = [];
  List<Campaign> _selectableCampaigns = [];

  final Duration _cacheValidDuration = const Duration(minutes: 30);
  DateTime _campaignLastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);

  CampaignRepository({
    AuthenticationRepository? authenticationRepository,
  }) {
    _gigaTurnipApiClient = GigaTurnipApiClient(
      httpClient: Dio(BaseOptions(baseUrl: GigaTurnipApiClient.baseUrl))
        ..interceptors.add(
          ApiInterceptor(authenticationRepository ?? AuthenticationRepository()),
        ),
    );
  }

  Future<void> refreshAllCampaigns() async {
    final userCampaignsData = await _gigaTurnipApiClient.getUserCampaigns();
    final userCampaigns = userCampaignsData.map((apiCampaign) {
      return Campaign.fromApiModel(apiCampaign);
    }).toList();

    final selectableCampaignsData = await _gigaTurnipApiClient.getSelectableCampaigns();
    final selectableCampaigns = selectableCampaignsData.map((apiCampaign) {
      return Campaign.fromApiModel(apiCampaign);
    }).toList();

    _campaignLastFetchTime = DateTime.now();
    _userCampaigns = userCampaigns;
    _selectableCampaigns = selectableCampaigns;
  }

  Future<List<Campaign>> getCampaigns({
    required CampaignsActions action,
    bool forceRefresh = false,
  }) async {
    bool shouldRefresh =
        shouldRefreshFromApi(_cacheValidDuration, _campaignLastFetchTime, forceRefresh) ||
            _userCampaigns.isEmpty;

    if (shouldRefresh) {
      await refreshAllCampaigns();
    }
    if (action == CampaignsActions.listUserCampaigns) {
      return _userCampaigns;
    } else {
      return _selectableCampaigns;
    }
  }

  Future<Campaign> getCampaignById(int id) async {
    final campaign = await _gigaTurnipApiClient.getCampaignById(id);
    return Campaign.fromApiModel(campaign);
  }

  Future<void> joinCampaign(int id) async {
    _gigaTurnipApiClient.joinCampaign(id);
  }
}
