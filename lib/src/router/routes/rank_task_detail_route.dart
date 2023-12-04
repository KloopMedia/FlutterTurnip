import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/rank_task_detail/rank_task_detail_page.dart';

class RankTaskDetailRoute {
  static String name = 'rankTaskDetail';

  static String path = "/ranktaskdetail";
  // static String path = "/rank/:rid/tasks/:tid";

  final GlobalKey<NavigatorState> parentKey;

  RankTaskDetailRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        // final query = state.uri.queryParameters;
        // final fromPath = query['from'];
        // if (fromPath != null && fromPath.isNotEmpty) {
        //   final id = Uri(path: fromPath).pathSegments.last;
        //   final campaignId = int.tryParse(id);
        //   return LoginPage(campaignId: campaignId);
        // }
        return const RankTaskDetailPage();
      },
    );
  }
}
