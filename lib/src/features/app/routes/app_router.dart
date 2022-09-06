import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
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
      if (!loggedIn) {
        return loggingIn ? null : '/login';
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return '/';
      }

      // no need to redirect at all
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        name: 'campaign',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
          return CampaignsPage(
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
              if (id != null) {
                return TasksPage(
                  campaignId: int.parse(id),
                  simpleViewMode: simpleViewMode,
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
                  if (id != null) {
                    return TaskPage(
                      taskId: int.parse(id),
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
