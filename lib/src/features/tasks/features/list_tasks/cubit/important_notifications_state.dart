part of 'important_notifications_cubit.dart';

abstract class ImportantNotificationsState {
  final List<Notifications> notifications;

  const ImportantNotificationsState(this.notifications);
}

class ImportantNotificationsInitial extends ImportantNotificationsState {
  const ImportantNotificationsInitial(super.notifications);
}

class ImportantNotificationsLoaded extends ImportantNotificationsState {
  const ImportantNotificationsLoaded(super.notifications);
}