part of 'notifications_cubit.dart';

enum NotificationsStatus {
  uninitialized,
  loading,
  initialized,
  error,
}

class NotificationsState extends Equatable {
  final List<Notifications> readNotifications;
  final List<Notifications> unreadNotifications;
  final NotificationsStatus status;
  final String? errorMessage;
  final Tabs selectedTab;
  final int tabIndex;

  const NotificationsState({
    this.readNotifications = const [],
    this.unreadNotifications = const [],
    this.status = NotificationsStatus.uninitialized,
    this. errorMessage,
    this.selectedTab = Tabs.unreadNotificationsTab,
    this.tabIndex = 0,
  });

  NotificationsState copyWith({
    List<Notifications>? readNotifications,
    List<Notifications>? unreadNotifications,
    NotificationsStatus? status,
    String? errorMessage,
    Tabs? selectedTab,
    int? tabIndex,
  }) {
    return NotificationsState(
      readNotifications: readNotifications ?? this.readNotifications,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  @override
  List<Object?> get props => [
    readNotifications,
    unreadNotifications,
    status,
    selectedTab,
    tabIndex,
  ];
}