part of 'notification_detail_bloc.dart';

abstract class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();

  @override
  List<Object> get props => [];
}

class InitializeNotification extends NotificationDetailEvent {}

class MarkNotificationAsViewed extends NotificationDetailEvent {}
