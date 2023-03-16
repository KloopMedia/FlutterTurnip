import 'package:flutter/material.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:go_router/go_router.dart';

class NotificationShellRoute {
  final GlobalKey<NavigatorState> navigatorKey;

  NotificationShellRoute({required this.navigatorKey});

  ShellRoute get route {
    return ShellRoute(
      navigatorKey: navigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final id = state.params['cid'] ?? '';

        final tabs = [
          ScaffoldWithNavBarTabItem(
            initialLocation: NotificationOpenRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.home),
            label: 'Open notifications',
          ),
          ScaffoldWithNavBarTabItem(
            initialLocation: NotificationClosedRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.settings),
            label: 'Closed notifications',
          ),
        ];

        return ScaffoldWithBottomNavBar(
          tabs: tabs,
          child: child,
        );
      },
      routes: [
        NotificationOpenRoute(parentKey: navigatorKey).route,
        NotificationClosedRoute(parentKey: navigatorKey).route,
      ],
    );
  }
}
