import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/notification/view/open_notification_page.dart';
import 'package:go_router/go_router.dart';

class NotificationOpenRoute {
  
  static String name = 'notificationOpen';

  
  static String path = "/campaign/:cid/notification/open";

  
  final GlobalKey<NavigatorState> parentKey;

  NotificationOpenRoute({required this.parentKey});

  
  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.params['cid'];
        if (id == null) {
          return Text(context.loc.unknown_page);
        }
        return OpenNotificationPage(
          campaignId: int.parse(id),
        );
      },
    );
  }
}
