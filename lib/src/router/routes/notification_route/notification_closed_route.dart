import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/notification/view/closed_notification_page.dart';
import 'package:go_router/go_router.dart';

class NotificationClosedRoute {
  static String name = 'notificationClosed';

  static String path = "/campaign/:cid/notification/closed";

  final GlobalKey<NavigatorState> parentKey;

  NotificationClosedRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.params['cid'];
        if (id == null) {
          return const Text('Unknown Page');
        }
        return ClosedNotificationPage(
          campaignId: int.parse(id),
        );
      },
    );
  }
}
