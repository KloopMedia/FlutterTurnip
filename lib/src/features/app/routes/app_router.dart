import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/settings/view/settings_page.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/view/task_page.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/view/view.dart';
import '../../campaigns/view/view.dart';
import '../../notifications/view/view.dart';
import '../../tasks/index.dart';

class AppRouter {
  final AuthenticationRepository _authenticationRepository;

  AppRouter(this._authenticationRepository);

  get router => _router;

  late final GoRouter _router = GoRouter(
    refreshListenable: GoRouterRefreshStream(_authenticationRepository.user),
    redirect: (routeState) {
      final bool loggedIn = _authenticationRepository.currentUser.isNotEmpty;
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
          final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
          return LoginPage(
            simpleViewMode: simpleViewMode,
          );
        },
      ),
      GoRoute(name: 'settings', path: '/settings', builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      }),
      GoRoute(
        name: 'campaign',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
          return CampaignsPage(
            key: UniqueKey(),
            simpleViewMode: simpleViewMode,
          );
        },
        routes: [
          GoRoute(
            name: 'tasks',
            path: 'campaign/:cid',
            builder: (BuildContext context, GoRouterState state) {
              final id = state.params['cid'];
              final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
              final shouldJoinCampaign = state.queryParams['join']?.toLowerCase() == 'true';
              final createTask = int.tryParse(state.queryParams['create_task'] ?? '');

              if (id != null) {
                return TasksPage(
                  campaignId: int.parse(id),
                  simpleViewMode: simpleViewMode,
                  shouldJoinCampaign: shouldJoinCampaign,
                  createTaskId: createTask,

                );
              }
              return const TasksPage();
            },
            routes: [
              GoRoute(
                name: 'createTasks',
                path: 'new-task',
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateTasksPage();
                },
              ),
              GoRoute(
                name: 'taskInstance',
                path: 'tasks/:tid',
                builder: (BuildContext context, GoRouterState state) {
                  final id = state.params['tid'];
                  final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
                  if (id != null) {
                    return TaskPage(
                      taskId: int.parse(id),
                      simpleViewMode: simpleViewMode,
                    );
                  }
                  return const TaskPage();
                },
              ),
              GoRoute(
                name: 'notifications',
                path: 'notifications',
                builder: (BuildContext context, GoRouterState state) {
                  return const NotificationsPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
