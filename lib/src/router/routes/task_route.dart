import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/view/create_task_page.dart';
import 'package:gigaturnip/src/features/task/view/task_page.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../utilities.dart';
import 'routes.dart';

class TaskRoute {
  static String name = 'tasks';

  static String path = "/campaign/:cid";

  final GlobalKey<NavigatorState> parentKey;

  TaskRoute({required this.parentKey});

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
    // final createTaskIdQueryValue = query['create_task'];

    if (joinCampaignQueryValue) {
      return await joinCampaign(context, state);
    }

    // if (createTaskIdQueryValue != null) {
    //   return await createTask(context, state);
    // }

    return null;
  }

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      redirect: redirect,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.params['cid'] ?? '';
        final campaign = state.extra;
        final createTaskIdQueryValue = state.queryParams['create_task'] ?? '';

        final campaignId = int.tryParse(id);
        if (campaignId == null) {
          return const Text('Error: Failed to parse id');
        }

        final createTaskId = int.tryParse(createTaskIdQueryValue);
        if (createTaskId != null) {
          return CreateTaskPage(taskId: createTaskId);
        }

        if (campaign != null && campaign is Campaign) {
          return TaskPage(campaignId: campaignId, campaign: campaign);
        }

        return TaskPage(campaignId: campaignId);
      },
    );
  }
}
