import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

abstract class NotificationRepository extends GigaTurnipRepository<Notification> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  NotificationRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Notification> parseData(List<api.Notification> data) {
    return data.map(Notification.fromApiModel).toList();
  }
}

class ClosedNotificationRepository extends NotificationRepository {
  ClosedNotificationRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<Notification>> fetchAndParseData(
      {Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserNotifications(query: {
      'campaign': campaignId,
      'viewed': true,
      ...?query,
    });

    return data.copyWith<Notification>(results: parseData(data.results));
  }
}

class OpenNotificationRepository extends NotificationRepository {
  OpenNotificationRepository({required super.gigaTurnipApiClient, required super.campaignId});

  @override
  Future<api.PaginationWrapper<Notification>> fetchAndParseData(
      {Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getUserNotifications(query: {
      'campaign': campaignId,
      'viewed': false,
      ...?query,
    });

    return data.copyWith<Notification>(results: parseData(data.results));
  }
}
