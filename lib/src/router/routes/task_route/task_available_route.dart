import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/view/available_task_page.dart';
import 'package:go_router/go_router.dart';

class TaskAvailableRoute {
  static String name = 'taskAvailable';

  static String path = "/campaign/:cid/task/available";

  final GlobalKey<NavigatorState> parentKey;

  TaskAvailableRoute({required this.parentKey});

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
        return AvailableTaskPage(campaignId: int.parse(id));
      },
    );
  }
}
