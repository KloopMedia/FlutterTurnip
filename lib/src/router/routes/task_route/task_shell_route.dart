import 'package:flutter/material.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:go_router/go_router.dart';

class TaskShellRoute {
  final GlobalKey<NavigatorState> navigatorKey;

  TaskShellRoute({required this.navigatorKey});

  ShellRoute get route {
    return ShellRoute(
      navigatorKey: navigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final id = state.params['cid'] ?? '';

        final tabs = [
          ScaffoldWithNavBarTabItem(
            initialLocation: TaskRelevantRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.home),
            label: 'Relevant Tasks',
          ),
          ScaffoldWithNavBarTabItem(
            initialLocation: TaskAvailableRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.settings),
            label: 'Available Tasks',
          ),
        ];

        return ScaffoldWithBottomNavBar(
          tabs: tabs,
          child: child,
        );
      },
      routes: [
        TaskRelevantRoute(parentKey: navigatorKey).route,
        TaskAvailableRoute(parentKey: navigatorKey).route,
      ],
    );
  }
}
