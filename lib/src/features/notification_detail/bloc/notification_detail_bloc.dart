import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'notification_detail_event.dart';

part 'notification_detail_state.dart';

class NotificationDetailBloc extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  final int notificationId;
  final NotificationDetailRepository _repository;

  NotificationDetailBloc({
    required NotificationDetailRepository repository,
    required this.notificationId,
    Notification? notification,
  })  : _repository = repository,
        super(
            notification != null ? NotificationLoaded(notification) : NotificationUninitialized()) {
    on<InitializeNotification>(_onInitializeNotification);
    on<MarkNotificationAsViewed>(_onMarkNotificationAsViewed);

    add(InitializeNotification());
  }

  Future<void> _onInitializeNotification(
    InitializeNotification event,
    Emitter<NotificationDetailState> emit,
  ) async {
    if (state is NotificationUninitialized) {
      emit(NotificationFetching());
      try {
        final data = await _repository.fetchData(notificationId);
        emit(NotificationLoaded(data));
        add(MarkNotificationAsViewed());
      } catch (e) {
        emit(NotificationFetchingError(e.toString()));
      }
    }
  }

  Future<void> _onMarkNotificationAsViewed(
    MarkNotificationAsViewed event,
    Emitter<NotificationDetailState> emit,
  ) async {
    try {
      await _repository.markNotificationAsViewed(notificationId);
    } catch (e, s) {
      print(e);
      print(s);
      emit(NotificationMarkingAsViewedError(e.toString()));
    }
  }
}
