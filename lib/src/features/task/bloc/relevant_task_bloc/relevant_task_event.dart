part of 'relevant_task_bloc.dart';

abstract class RelevantTaskEvent extends Equatable {
  const RelevantTaskEvent();

  @override
  List<Object> get props => [];
}

class FetchRelevantTaskData extends RelevantTaskEvent {
  final int page;

  const FetchRelevantTaskData(this.page);
}

class RefetchRelevantTaskData extends RelevantTaskEvent {
  final int page;

  const RefetchRelevantTaskData(this.page);
}
