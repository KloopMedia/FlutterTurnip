part of 'creatable_task_bloc.dart';

abstract class CreatableTaskEvent extends Equatable {
  const CreatableTaskEvent();
}

class FetchCreatableTaskData extends CreatableTaskEvent {
  final int page;

  const FetchCreatableTaskData(this.page);

  @override
  List<Object> get props => [page];
}

class RefetchCreatableTaskData extends CreatableTaskEvent {
  final int page;

  const RefetchCreatableTaskData(this.page);

  @override
  List<Object> get props => [page];
}

class CreateTask extends CreatableTaskEvent {
  final TaskStage task;

  const CreateTask(this.task);

  @override
  List<Object> get props => [task];
}
