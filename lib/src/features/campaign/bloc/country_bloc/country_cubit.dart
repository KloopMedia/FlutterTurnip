import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

part 'country_state.dart';

class CountryCubit extends RemoteDataCubit<Country> {
  final CountryRepository _repository;

  CountryCubit(this._repository);

  @override
  Future<PageData<Country>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}