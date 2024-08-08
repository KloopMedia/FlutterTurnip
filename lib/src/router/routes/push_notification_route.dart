import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:gigaturnip/src/features/notification_detail/view/push_notification_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/notification_detail/view/notification_detail_page.dart';

class PushNotificationRoute {
  static String name = 'pushNotificationDetail';

  static String path = "/notifications/push-notification";

  final GlobalKey<NavigatorState> parentKey;

  PushNotificationRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final message = state.extra as RemoteMessage;
        
        if (message.data.containsKey('campaign_id') && message.data.containsKey('notification_id')) {
          final notificationId = int.parse(message.data['notification_id']);
          final campaignId = int.parse(message.data['campaign_id']);

          return NotificationDetailPage(
            key: ValueKey(notificationId),
            notificationId: notificationId,
            campaignId: campaignId,
          );
        }
        

        return PushNotificationPage(notification: message.notification);
      },
    );
  }
}
