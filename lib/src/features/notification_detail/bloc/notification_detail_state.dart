part of 'notification_detail_bloc.dart';

abstract class NotificationDetailState extends Equatable {
  const NotificationDetailState();

  @override
  List<Object> get props => [];
}

class NotificationUninitialized extends NotificationDetailState {}

class NotificationFetching extends NotificationDetailState {}

class NotificationFetchingError extends NotificationDetailState {
  final String error;

  const NotificationFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class NotificationInitialized extends NotificationDetailState {
  final Notification data;

  const NotificationInitialized(this.data);

  NotificationInitialized.clone(NotificationInitialized state) : this(state.data);

  @override
  List<Object> get props => [data];
}

class NotificationLoaded extends NotificationInitialized {
  const NotificationLoaded(super.data);

  NotificationLoaded.clone(NotificationInitialized state) : super.clone(state);
}

class NotificationMarkingAsViewedError extends NotificationDetailState {
  final String error;

  const NotificationMarkingAsViewedError(this.error);

  @override
  List<Object> get props => [error];
}
