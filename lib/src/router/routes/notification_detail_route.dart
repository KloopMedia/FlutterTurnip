import 'package:flutter/material.dart' hide Notification;
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/notification_detail/view/notification_detail_page.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class NotificationDetailRoute {

  static String name = 'notificationDetail';


  static String path = "/campaign/:cid/notifications/:nid";


  final GlobalKey<NavigatorState> parentKey;

  NotificationDetailRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final notification = state.extra;

        if (notification != null && notification is Map) {
          final nid = notification['nid'];
          final cid = notification['cid'];

          if (nid == null || cid == null) {
            return Text(context.loc.unknown_page);
          }

          final notificationId = int.parse(nid);
          final campaignId = int.parse(cid);

          return NotificationDetailPage(
            key: ValueKey(notificationId),
            notificationId: notificationId,
            campaignId: campaignId,
          );
        } else if (notification != null && notification is Notification) {
            final nid = state.pathParameters['nid'];
            final cid = state.pathParameters['cid'];

            if (nid == null || cid == null) {
              return Text(context.loc.unknown_page);
            }

            final notificationId = int.parse(nid);
            final campaignId = int.parse(cid);

            return NotificationDetailPage(
              key: ValueKey(nid),
              notificationId: notificationId,
              campaignId: campaignId,
              notification: notification,
            );
        }
        final nid = state.pathParameters['nid'];
        final cid = state.pathParameters['cid'];

        if (nid == null || cid == null) {
          return Text(context.loc.unknown_page);
        }

        final notificationId = int.parse(nid);
        final campaignId = int.parse(cid);

        return NotificationDetailPage(
            key: ValueKey(notificationId),
            notificationId: notificationId,
            campaignId: campaignId,
          );
      },
    );
  }
}
