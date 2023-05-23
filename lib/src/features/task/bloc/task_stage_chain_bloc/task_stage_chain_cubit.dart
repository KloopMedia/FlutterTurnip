import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
part 'task_stage_chain_state.dart';

class TaskStageChainCubit extends RemoteDataCubit<Chain> {
  final TaskStageChainRepository _taskStageChainRepository;

  TaskStageChainCubit(this._taskStageChainRepository);

  @override
  Future<PageData<Chain>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _taskStageChainRepository.fetchDataOnPage(page, query);
  }
}