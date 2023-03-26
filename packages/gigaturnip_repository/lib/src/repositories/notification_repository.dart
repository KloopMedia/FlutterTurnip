import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

abstract class NotificationRepository extends GigaTurnipRepository<api.Notification, Notification> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  NotificationRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  List<Notification> parseData(List<api.Notification> data) {
    return data.map(Notification.fromApiModel).toList();
  }
}

class ClosedNotificationRepository extends NotificationRepository {
  ClosedNotificationRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<api.Notification>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserNotifications(query: {
      'campaign': campaignId,
      'viewed': true,
      ...?query,
    });
  }
}

class OpenNotificationRepository extends NotificationRepository {
  OpenNotificationRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<api.Notification>> fetchData({Map<String, dynamic>? query}) {
    return _gigaTurnipApiClient.getUserNotifications(query: {
      'campaign': campaignId,
      'viewed': false,
      ...?query,
    });
  }
}
