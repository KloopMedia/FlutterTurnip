part of 'previous_task_bloc.dart';

abstract class PreviousTaskEvent extends Equatable {
  const PreviousTaskEvent();

  @override
  List<Object> get props => [];
}

class FetchPreviousTask extends PreviousTaskEvent {}