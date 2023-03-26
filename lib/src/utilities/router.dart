import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/campaign/view/campaign_page.dart';
import 'package:gigaturnip/src/features/login/view/login_page.dart';
import 'package:gigaturnip/src/features/task/view/available_task_page.dart';
import 'package:gigaturnip/src/features/task_detail/view/task_detail_page.dart';
import 'package:gigaturnip/src/helpers/scaffold_with_bottom_navbar.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../features/task/view/relevant_task_page.dart';

class AppRouter {
  final RouterNotifier _authRouterNotifier;

  AppRouter(AuthenticationRepository authenticationRepository)
      : _authRouterNotifier = RouterNotifier(authenticationRepository);

  get router => _router;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router = GoRouter(
    refreshListenable: _authRouterNotifier,
    redirect: _authRouterNotifier.redirect,
    navigatorKey: _rootNavigatorKey,
    routes: <GoRoute>[
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
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              final id = state.params['cid'] ?? '';

              final tabs = [
                ScaffoldWithNavBarTabItem(
                  initialLocation: '/${Constants.taskRouteRelevant.path.replaceFirst(':cid', id)}',
                  icon: const Icon(Icons.home),
                  label: context.loc.relevant_tasks,
                ),
                ScaffoldWithNavBarTabItem(
                  initialLocation: '/${Constants.taskRouteAvailable.path.replaceFirst(':cid', id)}',
                  icon: const Icon(Icons.settings),
                  label: context.loc.available_tasks,
                ),
              ];

              return ScaffoldWithBottomNavBar(
                tabs: tabs,
                child: child,
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                name: Constants.taskRouteRelevant.name,
                path: Constants.taskRouteRelevant.path,
                builder: (BuildContext context, GoRouterState state) {
                  final id = state.params['cid'];
                  if (id == null) {
                    return Text(context.loc.unknown_page);
                  }
                  return RelevantTaskPage(
                    campaignId: int.parse(id),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                name: Constants.taskRouteAvailable.name,
                path: Constants.taskRouteAvailable.path,
                builder: (BuildContext context, GoRouterState state) {
                  final id = state.params['cid'];
                  if (id == null) {
                    return Text(context.loc.unknown_page);
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
                return Text(context.loc.unknown_page);
              }

              final taskId = int.parse(tid);
              final campaignId = int.parse(cid);

              if (task != null && task is Task) {
                return TaskDetailPage(taskId: taskId, campaignId: campaignId, task: task);
              }
              return TaskDetailPage(key: UniqueKey(), taskId: taskId, campaignId: campaignId);
            },
          ),
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
  final String name;

  const Route({required this.path, required this.name});
}
