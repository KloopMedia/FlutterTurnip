import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthenticationRepository _authenticationRepository;

  AppRouter(this._authenticationRepository);

  get router => _router;

  late final GoRouter _router = GoRouter(
    refreshListenable: GoRouterRefreshStream(_authenticationRepository.userStream),
    redirect: (routeState) {
      final bool loggedIn = _authenticationRepository.user.isNotEmpty;
      final bool loggingIn = routeState.subloc == '/login';

      // bundle the location the user is coming from into a query parameter
      final query = {...routeState.queryParams};
      var queryString = Uri(queryParameters: query).query;
      final fromp = routeState.subloc == '/' ? '' : '?from=${routeState.subloc}&$queryString';
      if (!loggedIn) return loggingIn ? null : '/login$fromp';

      // if the user is logged in, send them where they were going before (or
      // home if they weren't going anywhere)
      query.remove('from');
      queryString = Uri(queryParameters: query).query;
      if (loggingIn) return '${routeState.queryParams['from'] ?? '/'}?$queryString';

      // no need to redirect at all
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          throw UnimplementedError();
        },
      ),
      GoRoute(
        name: 'campaign',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          throw UnimplementedError();
        },
        routes: [],
      ),
    ],
  );
}
