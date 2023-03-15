import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class NotificationDetailRepository {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  NotificationDetailRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  Future<Notification> fetchData(int id) async {
    final task = await _gigaTurnipApiClient.getNotificationById(id);
    return Notification.fromApiModel(task);
  }

  Future<void> marNotificationAsViewed(int id) {
    return _gigaTurnipApiClient.openNotification(id);
  }
}
