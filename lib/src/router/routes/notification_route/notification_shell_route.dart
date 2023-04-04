import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
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
          BottomNavBarItemWithLocation(
            initialLocation: NotificationOpenRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.home),
            label: context.loc.open_notification,
          ),
          BottomNavBarItemWithLocation(
            initialLocation: NotificationClosedRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.settings),
            label: context.loc.closed_notification,
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
