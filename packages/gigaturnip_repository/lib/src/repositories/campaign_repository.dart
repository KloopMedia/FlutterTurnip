import 'dart:async';

import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

abstract class CampaignRepository extends GigaTurnipRepository<Campaign> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Campaign> parseData(List<api.Campaign> data) {
    return data.map((api.Campaign campaign) => Campaign.fromApiModel(campaign, true)).toList();
  }

  Future<List<Campaign>> fetchData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getCampaigns(query: query);
    return parseData(data.results);
  }

}

class UserCampaignRepository extends CampaignRepository {
  UserCampaignRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<Campaign>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserCampaigns(query: query);
    final List<Campaign> parsed = parseData(data.results);

    return data.copyWith<Campaign>(results: parsed);
  }
}

class SelectableCampaignRepository extends CampaignRepository {
  SelectableCampaignRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<Campaign>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getSelectableCampaigns(query: query);
    final List<Campaign> parsed = parseData(data.results);
    return data.copyWith<Campaign>(results: parsed);
  }
}
