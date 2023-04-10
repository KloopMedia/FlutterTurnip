import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task/view/task_page.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:go_router/go_router.dart';

import '../../utilities.dart';

class TaskShellRoute {
  final GlobalKey<NavigatorState> navigatorKey;

  TaskShellRoute({required this.navigatorKey});

  Future<String?> createTask(BuildContext context, GoRouterState state) async {
    final params = {...state.params};
    final query = {...state.queryParams};
    final queryString = toQueryString(query, 'create_task');

    try {
      final stageId = int.parse(query['create_task']!);
      final task = await context.read<GigaTurnipApiClient>().createTaskFromStageId(stageId);
      return '${TaskDetailRoute.path.replaceFirst(':cid', '${params['cid']}').replaceFirst(':tid', '${task.id}')}/?$queryString';
    } on FormatException {
      return '${state.subloc}?$queryString';
    }
  }

  Future<String?> joinCampaign(BuildContext context, GoRouterState state) async {
    final params = {...state.params};
    final query = {...state.queryParams};
    final queryString = toQueryString(query, 'join');

    try {
      final campaignId = int.parse(params['cid']!);
      await context.read<GigaTurnipApiClient>().joinCampaign(campaignId);
    } catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
    }
    return '${state.subloc}/?$queryString';
  }

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final query = {...state.queryParams};

    final joinCampaignQueryValue = query['join']?.toLowerCase() == 'true';
    final createTaskIdQueryValue = query['create_task'];

    if (joinCampaignQueryValue) {
      return await joinCampaign(context, state);
    }

    if (createTaskIdQueryValue != null) {
      return await createTask(context, state);
    }

    return null;
  }

  ShellRoute get route {
    return ShellRoute(
      navigatorKey: navigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final id = state.params['cid'] ?? '';

        final tabs = [
          ScaffoldWithNavBarTabItem(
            initialLocation: TaskRelevantRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.home),
            label: context.loc.relevant_tasks,
          ),
          ScaffoldWithNavBarTabItem(
            initialLocation: TaskAvailableRoute.path.replaceFirst(':cid', id),
            icon: const Icon(Icons.settings),
            label: context.loc.available_tasks,
          ),
        ];

        return TaskPage(
          tabs: tabs,
          child: child,
        );
      },
      routes: [
        TaskRelevantRoute(parentKey: navigatorKey, redirect: redirect).route,
        TaskAvailableRoute(parentKey: navigatorKey, redirect: redirect).route,
      ],
    );
  }
}
