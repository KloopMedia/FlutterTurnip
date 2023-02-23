import 'router.dart' show Route;

class Constants {
  Constants._();

  // Shared Preferences
  static const String sharedPrefLocaleKey = 'app_locale';

  // Router
  static const loginRoute = Route(path: '/login', name: 'login');
  static const campaignRoute = Route(path: '/', name: 'home');
  static const taskRoute = Route(path: 'campaign/:cid', name: 'task');
  static const taskDetailRoute = Route(path: 'task/:id', name: 'taskDetail');
  static const notificationRoute = Route(path: 'notification', name: 'notification');
}
