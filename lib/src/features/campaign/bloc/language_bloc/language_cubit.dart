import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

part 'language_state.dart';

class LanguageCubit extends RemoteDataCubit<Language> {
  final LanguageRepository _repository;

  LanguageCubit(this._repository);

  @override
  Future<PageData<Language>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}