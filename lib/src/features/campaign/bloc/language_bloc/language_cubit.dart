import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

part 'language_state.dart';

class LanguageCubit extends RemoteDataCubit<Language> {
  final LanguageRepository _repository;
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  LanguageCubit(this._repository, this._gigaTurnipApiClient);

  @override
  Future<PageData<Language>> fetchAndParseData(
    int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) {
    return _repository.fetchDataOnPage(page);
  }

  Future<List> loadData() async {
    final data = await _gigaTurnipApiClient.getLanguages(query: {});
    final List<Language> parsed = _repository.parseData(data.results);
    return parsed;
  }
}
