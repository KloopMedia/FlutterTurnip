part of 'notification_bloc.dart';

abstract class NotificationState extends RemoteDataType {
  @override
  List<Object> get props => [];
}

class NotificationUninitialized extends NotificationState {}

class NotificationFetching extends NotificationState with RemoteDataFetching {}

class NotificationFetchingError extends NotificationState with RemoteDataError {
  final String error;

  NotificationFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class NotificationInitialized extends NotificationState {
  final List<Notification> data;
  final int currentPage;
  final int total;

  NotificationInitialized({
    required this.data,
    required this.currentPage,
    required this.total,
  });

  NotificationInitialized.clone(NotificationInitialized state)
      : this(data: state.data, currentPage: state.currentPage, total: state.total);

  @override
  List<Object> get props => [data, currentPage, total];
}

class NotificationLoaded extends NotificationInitialized with RemoteDataSuccess {
  NotificationLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
  });
}

class NotificationRefetching extends NotificationInitialized with RemoteDataFetching {
  NotificationRefetching({
    required super.data,
    required super.currentPage,
    required super.total,
  });

  NotificationRefetching.clone(NotificationInitialized state) : super.clone(state);
}

class NotificationRefetchingError extends NotificationInitialized with RemoteDataError {
  final String error;

  NotificationRefetchingError({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  NotificationRefetchingError.clone(NotificationInitialized state, this.error) : super.clone(state);

  @override
  List<Object> get props => [...super.props, error];
}
