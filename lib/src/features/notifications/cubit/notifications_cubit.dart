import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'notifications_state.dart';

enum Tabs {
  readNotificationsTab,
  unreadNotificationsTab,
}

class NotificationsCubit extends Cubit<NotificationsState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final Campaign selectedCampaign;

  NotificationsCubit({
    required this.gigaTurnipRepository,
    required this.selectedCampaign,
  }) : super(const NotificationsState());

  void loadNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading));
    final readNotifications = await _getNotifications(true);
    final unreadNotifications = await _getNotifications(false);
    emit(state.copyWith(
      readNotifications: readNotifications,
      unreadNotifications: unreadNotifications,
      status: NotificationsStatus.initialized,
    ));
  }

  void getTaskNotifications(int taskId) async {
    final notifications = await _getNotifications(false) ?? [];
    final List<Notifications> taskNotifications = [];
    for (var item in notifications) {
      if (item.receiverTask == taskId) {
        taskNotifications.add(item);
      }
    }
    emit(state.copyWith(taskNotifications: taskNotifications));
  }

  Future<List<Notifications>?> _getNotifications(bool viewed) async {
    try {
      final notifications =
          await gigaTurnipRepository.getNotifications(selectedCampaign.id, viewed);
      return notifications ?? [];
    } on GigaTurnipApiRequestException catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: 'Failed to load notifications',
      ));
    }
    return null;
  }

  void onTabChange(int index) async {
    final tab = _getTabFromIndex(index);
    switch (tab) {
      case Tabs.unreadNotificationsTab:
        final unreadNotifications = await _getNotifications(false);
        emit(state.copyWith(readNotifications: unreadNotifications));
        break;
      case Tabs.readNotificationsTab:
        final readNotifications = await _getNotifications(true);
        emit(state.copyWith(readNotifications: readNotifications));
        break;
    }
    emit(
        state.copyWith(selectedTab: tab, tabIndex: index, status: NotificationsStatus.initialized));
  }

  Tabs _getTabFromIndex(int index) {
    switch (index) {
      case 0:
        return Tabs.unreadNotificationsTab;
      case 1:
        return Tabs.readNotificationsTab;
      default:
        throw Exception('Unknown index $index');
    }
  }

  void onReadNotification(int id) async {
    await gigaTurnipRepository.getOpenNotification(id);
  }
}
