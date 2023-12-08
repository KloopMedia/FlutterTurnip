import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'chain_state.dart';

class ChainCubit extends RemoteDataCubit<Chain> {
  final ChainRepository _repository;

  ChainCubit(this._repository);

  @override
  Future<PageData<Chain>> fetchAndParseData(
    int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) {
    return _repository.fetchDataOnPage(page, query);
  }
}
