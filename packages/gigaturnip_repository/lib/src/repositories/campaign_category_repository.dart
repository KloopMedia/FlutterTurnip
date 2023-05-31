import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

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