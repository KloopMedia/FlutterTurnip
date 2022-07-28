import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final Campaign selectedCampaign;

  NotificationsCubit({
    required this.gigaTurnipRepository,
    required this.selectedCampaign,
  }) : super(const NotificationsState());

  void loadNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading));
    try {
      final notifications = await gigaTurnipRepository.getNotifications(selectedCampaign.id);
      emit(state.copyWith(notifications: notifications, status: NotificationsStatus.initialized));
    } on GigaTurnipApiRequestException catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: e.message,
        notifications: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: 'Failed to load notifications',
        notifications: [],
      ));
    }
  }
}
