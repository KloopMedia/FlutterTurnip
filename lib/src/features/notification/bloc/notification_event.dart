part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotificationData extends NotificationEvent {
  final int page;

  const FetchNotificationData(this.page);
}

class RefetchNotificationData extends NotificationEvent {
  final int page;

  const RefetchNotificationData(this.page);
}
