import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task_detail/view/task_detail_page.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class TaskDetailRoute {
  static String name = 'taskDetail';

  static String path = "/campaign/:cid/tasks/:tid";

  final GlobalKey<NavigatorState> parentKey;

  const TaskDetailRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
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
          return TaskDetailPage(
            key: ValueKey(tid),
            taskId: taskId,
            campaignId: campaignId,
            task: task,
          );
        }
        return TaskDetailPage(
          key: ValueKey(tid),
          taskId: taskId,
          campaignId: campaignId,
        );
      },
    );
  }
}
