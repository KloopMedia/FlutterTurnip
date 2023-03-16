import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:gigaturnip/src/features/campaign/view/campaign_page.dart';
import 'package:gigaturnip/src/features/campaign_detail/view/campaign_detail_page.dart';
import 'package:gigaturnip/src/features/login/view/login_page.dart';
import 'package:gigaturnip/src/features/notification/view/closed_notification_page.dart';
import 'package:gigaturnip/src/features/notification/view/open_notification_page.dart';
import 'package:gigaturnip/src/features/notification_detail/view/notification_detail_page.dart';
import 'package:gigaturnip/src/features/task/view/available_task_page.dart';
import 'package:gigaturnip/src/features/task/view/relevant_task_page.dart';
import 'package:gigaturnip/src/features/task_detail/view/task_detail_page.dart';
import 'package:gigaturnip/src/helpers/scaffold_with_bottom_navbar.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final RouterNotifier _authRouterNotifier;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _authRouterNotifier = RouterNotifier(authenticationRepository);

  get router => _router;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _taskPageShellNavigatorKey = GlobalKey<NavigatorState>();
  final _notificationPageShellNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router = GoRouter(
    refreshListenable: _authRouterNotifier,
    redirect: _authRouterNotifier.redirect,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: Constants.loginRoute.name,
        path: Constants.loginRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: Constants.campaignRoute.name,
        path: Constants.campaignRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          return const CampaignPage();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: Constants.campaignDetailRoute.name,
        path: Constants.campaignDetailRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          final campaign = state.extra;
          final cid = state.params['cid'] ?? '';

          final campaignId = int.parse(cid);

          if (campaign != null && campaign is Campaign) {
            return CampaignDetailPage(
              key: ValueKey(cid),
              campaignId: campaignId,
              campaign: campaign,
            );
          }
          return CampaignDetailPage(key: ValueKey(cid), campaignId: campaignId);
        },
      ),
      ShellRoute(
        navigatorKey: _taskPageShellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final id = state.params['cid'] ?? '';

          final tabs = [
            ScaffoldWithNavBarTabItem(
              initialLocation: Constants.relevantTaskRoute.path.replaceFirst(':cid', id),
              icon: const Icon(Icons.home),
              label: 'Relevant Tasks',
            ),
            ScaffoldWithNavBarTabItem(
              initialLocation: Constants.availableTaskRoute.path.replaceFirst(':cid', id),
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
          GoRoute(
            parentNavigatorKey: _taskPageShellNavigatorKey,
            name: Constants.relevantTaskRoute.name,
            path: Constants.relevantTaskRoute.path,
            builder: (BuildContext context, GoRouterState state) {
              final id = state.params['cid'];
              if (id == null) {
                return const Text('Unknown Page');
              }
              return RelevantTaskPage(
                campaignId: int.parse(id),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _taskPageShellNavigatorKey,
            name: Constants.availableTaskRoute.name,
            path: Constants.availableTaskRoute.path,
            builder: (BuildContext context, GoRouterState state) {
              final id = state.params['cid'];
              if (id == null) {
                return const Text('Unknown Page');
              }
              return AvailableTaskPage(campaignId: int.parse(id));
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: Constants.taskDetailRoute.name,
        path: Constants.taskDetailRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          final task = state.extra;
          final tid = state.params['tid'];
          final cid = state.params['cid'];

          if (tid == null || cid == null) {
            return const Text('Unknown Page');
          }

          final taskId = int.parse(tid);
          final campaignId = int.parse(cid);

          if (task != null && task is Task) {
            return TaskDetailPage(
                key: ValueKey(tid), taskId: taskId, campaignId: campaignId, task: task);
          }
          return TaskDetailPage(key: ValueKey(tid), taskId: taskId, campaignId: campaignId);
        },
      ),
      ShellRoute(
        navigatorKey: _notificationPageShellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final id = state.params['cid'] ?? '';

          final tabs = [
            ScaffoldWithNavBarTabItem(
              initialLocation: Constants.openNotificationRoute.path.replaceFirst(':cid', id),
              icon: const Icon(Icons.home),
              label: 'Open notifications',
            ),
            ScaffoldWithNavBarTabItem(
              initialLocation: Constants.closedNotificationRoute.path.replaceFirst(':cid', id),
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
          GoRoute(
            parentNavigatorKey: _notificationPageShellNavigatorKey,
            name: Constants.openNotificationRoute.name,
            path: Constants.openNotificationRoute.path,
            builder: (BuildContext context, GoRouterState state) {
              final id = state.params['cid'];
              if (id == null) {
                return const Text('Unknown Page');
              }
              return OpenNotificationPage(
                campaignId: int.parse(id),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _notificationPageShellNavigatorKey,
            name: Constants.closedNotificationRoute.name,
            path: Constants.closedNotificationRoute.path,
            builder: (BuildContext context, GoRouterState state) {
              final id = state.params['cid'];
              if (id == null) {
                return const Text('Unknown Page');
              }
              return ClosedNotificationPage(campaignId: int.parse(id));
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: Constants.notificationDetailRoute.name,
        path: Constants.notificationDetailRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          final notification = state.extra;
          final nid = state.params['nid'];
          final cid = state.params['cid'];

          if (nid == null || cid == null) {
            return const Text('Unknown Page');
          }

          final notificationId = int.parse(nid);
          final campaignId = int.parse(cid);

          if (notification != null && notification is Notification) {
            return NotificationDetailPage(
              key: ValueKey(nid),
              notificationId: notificationId,
              campaignId: campaignId,
              notification: notification,
            );
          }
          return NotificationDetailPage(
            key: ValueKey(nid),
            notificationId: notificationId,
            campaignId: campaignId,
          );
        },
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
  final String name;

  const Route({required this.path, required this.name});
}
