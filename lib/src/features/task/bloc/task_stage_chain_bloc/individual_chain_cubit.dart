import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
part 'individual_chain_state.dart';

class IndividualChainCubit extends RemoteDataCubit<IndividualChain> {
  final IndividualChainRepository _repository;

  IndividualChainCubit(this._repository);

  @override
  Future<PageData<IndividualChain>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page, query);
  }
}