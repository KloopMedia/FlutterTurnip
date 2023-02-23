import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

abstract class CampaignRepository extends GigaTurnipRepository<api.Campaign, Campaign> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  List<Campaign> parseData(List<api.Campaign> data) {
    return data.map((api.Campaign campaign) => Campaign.fromApiModel(campaign, true)).toList();
  }
}

class UserCampaignRepository extends CampaignRepository {
  UserCampaignRepository({required super.gigaTurnipApiClient});

  @override
  Future<api.PaginationWrapper<api.Campaign>> fetchData({Map<String, dynamic>? query}) async {
    // return await _gigaTurnipApiClient.getUserCampaigns(query: query);
    final results = await _gigaTurnipApiClient.getUserCampaigns(query: query);
    final wrapper = api.PaginationWrapper(count: results.length, results: results);
    return wrapper;
  }
}

class SelectableCampaignRepository extends CampaignRepository {
  SelectableCampaignRepository({required super.gigaTurnipApiClient});

  @override
  Future<api.PaginationWrapper<api.Campaign>> fetchData({Map<String, dynamic>? query}) async {
    final results = await _gigaTurnipApiClient.getSelectableCampaigns(query: query);
    final wrapper = api.PaginationWrapper(count: results.length, results: results);
    return wrapper;
  }

  Future<void> joinCampaign(int id) async {
    await _gigaTurnipApiClient.joinCampaign(id);
  }
}
