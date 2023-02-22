import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

class SelectableCampaignRepository extends GigaTurnipRepository<api.Campaign, Campaign> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  SelectableCampaignRepository(this._gigaTurnipApiClient);

  @override
  Future<api.PaginationWrapper<api.Campaign>> fetchData({Map<String, dynamic>? query}) async {
    final results = await _gigaTurnipApiClient.getSelectableCampaigns(query: query);
    final wrapper = api.PaginationWrapper(count: results.length, results: results);
    return wrapper;
  }

  @override
  List<Campaign> parseData(List<api.Campaign> data) {
    return data.map((api.Campaign campaign) => Campaign.fromApiModel(campaign, true)).toList();
  }

  Future<void> joinCampaign(int id) async {
    await _gigaTurnipApiClient.joinCampaign(id);
  }
}
