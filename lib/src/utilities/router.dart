import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/view/campaign_page.dart';
import 'package:gigaturnip/src/features/login/view/login_page.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final RouterNotifier _authRouterNotifier;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _authRouterNotifier = RouterNotifier(authenticationRepository);

  get router => _router;

  late final GoRouter _router = GoRouter(
    refreshListenable: _authRouterNotifier,
    redirect: _authRouterNotifier.redirect,
    routes: <GoRoute>[
      GoRoute(
        name: Constants.loginRoute.name,
        path: Constants.loginRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        name: Constants.campaignRoute.name,
        path: Constants.campaignRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          return const CampaignPage();
        },
        routes: [
          GoRoute(
            name: Constants.taskRoute.name,
            path: Constants.taskRoute.path,
            builder: (BuildContext context, GoRouterState state) {
              final id = state.params['cid'];
              throw UnimplementedError();
            },
          )
        ],
      ),
    ],
  );
}

class RouterNotifier extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<dynamic> _subscription;

  RouterNotifier(this._authenticationRepository) {
    notifyListeners();
    _subscription = _authenticationRepository.userStream
        .asBroadcastStream()
        .listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final bool loggedIn = _authenticationRepository.user.isNotEmpty;
    final bool loggingIn = state.subloc == '/login';

    // bundle the location the user is coming from into a query parameter
    final query = {...state.queryParams};
    var queryString = Uri(queryParameters: query).query;
    final fromPage = state.subloc == '/' ? '' : '?from=${state.subloc}&$queryString';
    if (!loggedIn) return loggingIn ? null : '/login$fromPage';

    // if the user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    query.remove('from');
    queryString = Uri(queryParameters: query).query;
    if (loggingIn) return '${state.queryParams['from'] ?? '/'}?$queryString';

    // no need to redirect at all
    return null;
  }
}

class Route {
  final String path;
  final String? name;

  const Route({required this.path, this.name});
}
