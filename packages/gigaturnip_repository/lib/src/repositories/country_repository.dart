import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

class CountryRepository extends GigaTurnipRepository<Country> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CountryRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Country> parseData(List<api.Country> data) {
    return data.map((api.Country country) => Country.fromApiModel(country)).toList();
  }

  @override
  Future<api.PaginationWrapper<Country>> fetchAndParseData({Map<String, dynamic>? query}) async {
    try {
      final data = await _gigaTurnipApiClient.getCountries(query: query);
      final List<Country> parsed = parseData(data.results);
      return data.copyWith<Country>(results: parsed);
    } catch (e) {
      return api.PaginationWrapper(count: 0, results: []);
    }
  }
}