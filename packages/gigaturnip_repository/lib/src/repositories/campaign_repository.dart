import 'dart:async';

import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:local_database/local_database.dart' as db;

abstract class CampaignRepository extends GigaTurnipRepository<Campaign> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Campaign> parseData(List<api.Campaign> data) {
    return data.map((api.Campaign campaign) => Campaign.fromApiModel(campaign, true)).toList();
  }
}

class UserCampaignRepository extends CampaignRepository {
  UserCampaignRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<Campaign>> fetchAndParseData({Map<String, dynamic>? query}) async {
    try {
      final data = await _gigaTurnipApiClient.getUserCampaigns(query: query);
      final List<Campaign> parsed = parseData(data.results);

      for (final campaign in parsed) {
        final entity = campaign.toDB();
        await db.LocalDatabase.insertCampaign(entity);
      }

      return data.copyWith<Campaign>(results: parsed);
    } catch (e) {
      final data = await db.LocalDatabase.getCampaigns();
      final parsed = data.map(Campaign.fromDB).toList();
      return api.PaginationWrapper(count: parsed.length, results: parsed);
    }
  }
}

class SelectableCampaignRepository extends CampaignRepository {
  SelectableCampaignRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<Campaign>> fetchAndParseData({Map<String, dynamic>? query}) async {
    try {
      final data = await _gigaTurnipApiClient.getSelectableCampaigns(query: query);
      final List<Campaign> parsed = parseData(data.results);

      for (final campaign in parsed) {
        final entity = campaign.toDB();
        await db.LocalDatabase.insertCampaign(entity);
      }

      return data.copyWith<Campaign>(results: parsed);
    } catch (e) {
      final data = await db.LocalDatabase.getCampaigns();
      final parsed = data.map(Campaign.fromDB).toList();
      return api.PaginationWrapper(count: parsed.length, results: parsed);
    }
  }
}