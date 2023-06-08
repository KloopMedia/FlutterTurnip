import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

class LanguageRepository extends GigaTurnipRepository<Language> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  LanguageRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Language> parseData(List<api.Language> data) {
    return data.map((api.Language language) => Language.fromApiModel(language)).toList();
  }

  @override
  Future<api.PaginationWrapper<Language>> fetchAndParseData({Map<String, dynamic>? query}) async {
    try {
      final data = await _gigaTurnipApiClient.getLanguages(query: query);
      final List<Language> parsed = parseData(data.results);
      return data.copyWith<Language>(results: parsed);
    } catch (e) {
      return api.PaginationWrapper(count: 0, results: []);
    }
  }
}