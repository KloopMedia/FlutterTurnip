import 'package:flutter/material.dart' hide Notification;
import 'package:gigaturnip/src/features/notification_detail/view/notification_detail_page.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class NotificationDetailRoute {
  
  static String name = 'notificationDetail';

  
  static String path = "/campaign/:cid/notification/:nid";

  
  final GlobalKey<NavigatorState> parentKey;

  NotificationDetailRoute({required this.parentKey});

  
  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final notification = state.extra;
        final nid = state.params['nid'];
        final cid = state.params['cid'];

        if (nid == null || cid == null) {
          return const Text('Unknown Page');
        }

        final notificationId = int.parse(nid);
        final campaignId = int.parse(cid);

        if (notification != null && notification is Notification) {
          return NotificationDetailPage(
            key: ValueKey(nid),
            notificationId: notificationId,
            campaignId: campaignId,
            notification: notification,
          );
        }
        return NotificationDetailPage(
          key: ValueKey(nid),
          notificationId: notificationId,
          campaignId: campaignId,
        );
      },
    );
  }
}
