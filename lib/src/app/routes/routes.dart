class Routes {
  static const login = _RouteInfo('login', '/login');
  static const campaign = _RouteInfo('campaign', '/');
  static const task = _RouteInfo('task', '/task');
  static const notification = _RouteInfo('notification', '/notification');
}

class _RouteInfo {
  final String name;
  final String path;

  const _RouteInfo(this.name, this.path);
}
