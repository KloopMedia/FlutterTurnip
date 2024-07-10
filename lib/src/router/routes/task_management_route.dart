import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/chain/view/chain_page.dart';
import 'package:gigaturnip/src/features/task_management/view/task_management_page.dart';
import 'package:go_router/go_router.dart';

class TaskManagementRoute {
  static String name = 'create_tasks';

  static String path = "/campaign/:cid/chains/:chainId/tasks";

  final GlobalKey<NavigatorState> parentKey;

  TaskManagementRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['cid'] ?? '';
        final chainId = state.pathParameters['chainId'] ?? '';

        final campaignId = int.tryParse(id);
        final parsedChainId = int.tryParse(chainId);
        if (campaignId == null || parsedChainId == null) {
          return const Text('Error: Failed to parse id');
        }
        return TaskManagementPage(campaignId: campaignId, chainId: parsedChainId);
      },
    );
  }
}
