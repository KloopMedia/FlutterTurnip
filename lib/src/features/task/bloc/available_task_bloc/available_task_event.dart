part of 'available_task_bloc.dart';

abstract class AvailableTaskEvent extends Equatable {
  const AvailableTaskEvent();

  @override
  List<Object> get props => [];
}

class FetchAvailableTaskData extends AvailableTaskEvent {
  final int page;

  const FetchAvailableTaskData(this.page);
}

class RefetchAvailableTaskData extends AvailableTaskEvent {
  final int page;

  const RefetchAvailableTaskData(this.page);
}
