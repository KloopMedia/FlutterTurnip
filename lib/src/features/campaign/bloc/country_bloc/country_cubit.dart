import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

part 'country_state.dart';

class CountryCubit extends RemoteDataCubit<Country> {
  final CountryRepository _repository;
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  CountryCubit(this._repository, this._gigaTurnipApiClient);

  @override
  Future<PageData<Country>> fetchAndParseData(int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) {
    return _repository.fetchDataOnPage(page);
  }

  Future<List> loadData() async {
    final data = await _gigaTurnipApiClient.getCountries(query: {});
    final List<Country> parsed = _repository.parseData(data.results);
    return parsed;
  }
}