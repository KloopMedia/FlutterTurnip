import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

part 'task_stage_chain_state.dart';

class TaskStageChainCubit extends RemoteDataCubit<Chain> {
  final TaskStageChainRepository _repository;

  TaskStageChainCubit(this._repository);

  @override
  Future<PageData<Chain>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page, query);
  }
}