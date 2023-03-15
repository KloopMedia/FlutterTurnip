import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'notification_event.dart';

part 'notification_state.dart';

mixin ClosedNotificationBloc on Bloc<NotificationEvent, NotificationState> {}
mixin OpenNotificationBloc on Bloc<NotificationEvent, NotificationState> {}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState>
    with ClosedNotificationBloc, OpenNotificationBloc {
  final NotificationRepository _repository;

  NotificationBloc(this._repository) : super(NotificationUninitialized()) {
    on<FetchNotificationData>(_onFetchNotificationData);
    on<RefetchNotificationData>(_onRefetchNotificationData);
    add(const FetchNotificationData(0));
  }

  Future<void> _onFetchNotificationData(
    FetchNotificationData event,
    Emitter<NotificationState> emit,
  ) async {
    final page = event.page;
    try {
      emit(NotificationFetching());

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(NotificationLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(NotificationFetchingError(e.toString()));
      emit(state);
    }
  }

  Future<void> _onRefetchNotificationData(
    RefetchNotificationData event,
    Emitter<NotificationState> emit,
  ) async {
    final page = event.page;
    try {
      emit(NotificationRefetching.clone(state as NotificationLoaded));

      final data = await _repository.fetchDataOnPage(page);
      final currentPage = _repository.currentPage;
      final total = _repository.total;

      emit(NotificationLoaded(
        data: data,
        currentPage: currentPage,
        total: total,
      ));
    } on Exception catch (e) {
      print(e);
      emit(NotificationRefetchingError.clone(state as NotificationLoaded, e.toString()));
      emit(state);
    }
  }
}
