import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

abstract class CampaignRepository extends GigaTurnipRepository<api.Campaign, Campaign> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  List<Campaign> parseData(List<api.Campaign> data) {
    return data.map((api.Campaign campaign) => Campaign.fromApiModel(campaign, true)).toList();
  }
}

class UserCampaignRepository extends CampaignRepository {
  UserCampaignRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<api.Campaign>> fetchData({Map<String, dynamic>? query}) async {
    return _gigaTurnipApiClient.getUserCampaigns(query: query);
  }
}

class SelectableCampaignRepository extends CampaignRepository {
  SelectableCampaignRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<api.Campaign>> fetchData({Map<String, dynamic>? query}) async {
    return _gigaTurnipApiClient.getSelectableCampaigns(query: query);
  }
}

class CampaignCategoryRepository extends GigaTurnipRepository<api.Category, Category> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CampaignCategoryRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  Future<api.PaginationWrapper<api.Category>> fetchData({Map<String, dynamic>? query}) async {
    return _gigaTurnipApiClient.getCampaignCategories(query: query);
  }

  @override
  List<Category> parseData(List<api.Category> data) {
    return data.map((api.Category category) => Category.fromApiModel(category)).toList();
  }
}
