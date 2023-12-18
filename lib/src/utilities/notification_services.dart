import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../router/routes/routes.dart';

class NotificationServices {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  void getDeviceToken(gigaTurnipApiClient, token) async {
    await gigaTurnipApiClient.updateFcmToken({'fcm_token': token});
  }

  Future<void> initialize(GoRouter router) async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.getInitialMessage();

    onMessageListen(router);

    onMessageOpenedAppListen(router);
  }

  void onMessageOpenedAppListen(GoRouter router) {
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      _handleMessage(message, router);
    });
  }

  void onMessageListen(GoRouter router) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      var androidInitialize = const AndroidInitializationSettings('launcher_icon');
      var initializationSettings = InitializationSettings(android: androidInitialize);
      _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (NotificationResponse? response) async {
            _handleMessage(message, router);
          }
      );

      /// show message
      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/launcher_icon',
              ),
            ));
      }
    });
  }

  void _handleMessage(RemoteMessage message, GoRouter router) {
    router.go(
      NotificationDetailRoute.path,
      extra: {
        'cid': message.data['campaign_id'],
        'nid': message.data['notification_id'],
      },
    );
  }
}