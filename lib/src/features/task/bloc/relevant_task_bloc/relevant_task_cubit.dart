import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'relevant_task_state.dart';

mixin OpenTaskCubit on RemoteDataCubit<Task> {}
mixin ClosedTaskCubit on RemoteDataCubit<Task> {}

class RelevantTaskCubit extends RemoteDataCubit<Task> with OpenTaskCubit, ClosedTaskCubit {
  final TaskRepository _repository;

  RelevantTaskCubit(this._repository);

  @override
  Future<PageData<Task>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page, query);
  }

  void refetchWithFilter(int page, TaskFilterOptions filter) {
    Map<String, dynamic>? query;
    switch (filter) {
      case TaskFilterOptions.incomplete:
        query = {'complete': false};
        break;
      case TaskFilterOptions.complete:
        query = {'complete': true};
        break;
      case TaskFilterOptions.returned:
        break;
      case TaskFilterOptions.all:
        break;
    }
    super.setFilter(query);
    super.fetchData(page);
  }
}

enum TaskFilterOptions { incomplete, complete, returned, all }

const taskFilterMap = {
  TaskFilterOptions.incomplete: 'Активные',
  TaskFilterOptions.returned: 'Возвращенные',
  TaskFilterOptions.complete: 'Отправленные',
  TaskFilterOptions.all: 'Все',
};
