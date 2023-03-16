import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/view/relevant_task_page.dart';
import 'package:go_router/go_router.dart';

class TaskRelevantRoute {
  static const String name = 'taskRelevant';

  static String path = "/campaign/:cid/task/relevant";

  final GlobalKey<NavigatorState> parentKey;

  TaskRelevantRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.params['cid'];
        if (id == null) {
          return const Text('Unknown Page');
        }
        return RelevantTaskPage(
          campaignId: int.parse(id),
        );
      },
    );
  }
}
