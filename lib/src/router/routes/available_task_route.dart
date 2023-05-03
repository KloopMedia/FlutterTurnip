import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task/view/available_task_page.dart';
import 'package:go_router/go_router.dart';

class AvailableTaskRoute {
  static String name = 'availableTasks';

  static String path = "/campaign/:cid/available/:tid";

  final GlobalKey<NavigatorState> parentKey;

  AvailableTaskRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final cid = state.params['cid'] ?? '';
        final tid = state.params['tid'] ?? '';

        final campaignId = int.tryParse(cid);
        final stageId = int.tryParse(tid);
        if (stageId == null || campaignId == null) {
          return Text(context.loc.unknown_page);
        }

        return AvailableTaskPage(campaignId: campaignId, stageId: stageId);
      },
    );
  }
}
