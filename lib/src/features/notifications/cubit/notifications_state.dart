part of 'notifications_cubit.dart';

enum NotificationsStatus {
  uninitialized,
  loading,
  initialized,
  error,
}

class NotificationsState extends Equatable {
  final List<Notifications> notifications;
  final NotificationsStatus status;
  final String? errorMessage;

  const NotificationsState({
    this.notifications = const [],
    this.status = NotificationsStatus.uninitialized,
    this. errorMessage,
  });

  NotificationsState copyWith({
    List<Notifications>? notifications,
    NotificationsStatus? status,
    String? errorMessage
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [notifications, status];
}