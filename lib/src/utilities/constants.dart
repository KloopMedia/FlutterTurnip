import 'router.dart' show Route;

class Constants {
  Constants._();

  // Shared Preferences
  static const String sharedPrefLocaleKey = 'app_locale';

  // Router
  static const loginRoute = Route(
    path: '/login',
    name: 'login',
  );
  static const campaignRoute = Route(
    path: '/',
    name: 'home',
  );
  static const relevantTaskRoute = Route(
    path: '/campaign/:cid/relevant',
    name: 'taskRelevant',
  );
  static const availableTaskRoute = Route(
    path: '/campaign/:cid/available',
    name: 'taskAvailable',
  );
  static const taskDetailRoute = Route(
    path: '/campaign/:cid/task/:tid',
    name: 'taskDetail',
  );
  static const openNotificationRoute = Route(
    path: '/campaign/:cid/notification/open',
    name: 'notificationOpen',
  );
  static const closedNotificationRoute = Route(
    path: '/campaign/:cid/notification/closed',
    name: 'notificationClosed',
  );
  static const notificationDetailRoute = Route(
    path: '/campaign/:cid/notification/:nid',
    name: 'notificationDetail',
  );
}
