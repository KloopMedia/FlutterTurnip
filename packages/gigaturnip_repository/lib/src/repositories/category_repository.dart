import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

class CategoryRepository extends GigaTurnipRepository<Category> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CategoryRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Category> parseData(List<api.Category> data) {
    return data.map((api.Category category) => Category.fromApiModel(category)).toList();
  }

  @override
  Future<api.PaginationWrapper<Category>> fetchAndParseData({Map<String, dynamic>? query}) async {
    try {
      final data = await _gigaTurnipApiClient.getCategories(query: query);
      final List<Category> parsed = parseData(data.results);
      return data.copyWith<Category>(results: parsed);
    } catch (e) {
      return api.PaginationWrapper(count: 0, results: []);
    }
  }
}