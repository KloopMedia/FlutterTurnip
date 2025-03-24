import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'book_chain_state.dart';

class BookChainCubit extends RemoteDataCubit<IndividualChain> {
  final BookChainRepository _repository;

  BookChainCubit(this._repository);

  @override
  Future<PageData<IndividualChain>> fetchAndParseData(
    int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) {
    return _repository.fetchDataOnPage(page, query);
  }
}
