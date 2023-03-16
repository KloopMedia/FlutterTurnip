import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class NotificationDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  NotificationDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<Notification> fetchData(int id) async {
    final notification = await _gigaTurnipApiClient.getNotificationById(id);
    return Notification.fromApiModel(notification);
  }

  Future<void> markNotificationAsViewed(int id) {
    return _gigaTurnipApiClient.openNotification(id);
  }
}
