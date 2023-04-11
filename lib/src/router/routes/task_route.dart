import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/view/task_page.dart';
import 'package:go_router/go_router.dart';

class TaskRoute {
  static String name = 'task';

  static String path = "/campaign/:cid";

  final GlobalKey<NavigatorState> parentKey;

  TaskRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.params['cid'] ?? '';

        final campaignId = int.tryParse(id);
        if (campaignId == null) {
          return const Text('Error: Failed to parse id');
        }

        return TaskPage(campaignId: campaignId);
      },
    );
  }
}
