class Constants {
  Constants._();

  // Shared Preferences
  static const String sharedPrefLocaleKey = 'app_locale';

  // Router
  static const loginRoute = '/login';
  static const campaignRoute = '/';
  static const taskRoute = 'campaign/:cid';
  static const taskDetailRoute = 'task/:id';
  static const notificationRoute = '/notification';
}
