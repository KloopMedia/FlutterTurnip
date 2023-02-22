import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

class UserCampaignRepository extends GigaTurnipRepository<api.Campaign, Campaign> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  UserCampaignRepository(this._gigaTurnipApiClient);

  @override
  Future<api.PaginationWrapper<api.Campaign>> fetchData({Map<String, dynamic>? query}) async {
    // return await _gigaTurnipApiClient.getUserCampaigns(query: query);
    final results = await _gigaTurnipApiClient.getUserCampaigns(query: query);
    final wrapper = api.PaginationWrapper(count: results.length, results: results);
    return wrapper;
  }

  @override
  List<Campaign> parseData(List<api.Campaign> data) {
    return data.map((api.Campaign campaign) => Campaign.fromApiModel(campaign, false)).toList();
  }
}
