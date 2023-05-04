import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'selectable_task_stage_state.dart';

class SelectableTaskStageCubit extends RemoteDataCubit<TaskStage> {
  final SelectableTaskStageRepository _repository;

  SelectableTaskStageCubit(this._repository);

  @override
  Future<PageData<TaskStage>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}
