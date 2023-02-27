import 'router.dart' show Route;

class Constants {
  Constants._();

  // Shared Preferences
  static const String sharedPrefLocaleKey = 'app_locale';

  // Router
  static const loginRoute = Route(path: '/login', name: 'login');
  static const campaignRoute = Route(path: '/', name: 'home');
  static const taskRouteRelevant = Route(path: 'campaign/:cid/relevant', name: 'taskRelevant');
  static const taskRouteAvailable = Route(path: 'campaign/:cid/available', name: 'taskAvailable');
  static const taskDetailRoute = Route(path: 'campaign/:cid/task/:tid', name: 'taskDetail');
  static const notificationRoute = Route(path: 'notification', name: 'notification');
}
