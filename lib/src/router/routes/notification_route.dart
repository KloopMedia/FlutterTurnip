import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/notification/view/notification_page.dart';
import 'package:go_router/go_router.dart';

class NotificationRoute {
  static String name = 'notifications';

  static String path = "/campaign/:cid/notifications";

  final GlobalKey<NavigatorState> parentKey;

  NotificationRoute({required this.parentKey});

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
        return NotificationPage(
          campaignId: int.parse(id),
        );
      },
    );
  }
}
