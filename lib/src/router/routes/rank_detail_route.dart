import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/rank_detail/rank_detail_page.dart';

class RankDetailRoute {
  static String name = 'rankDetail';

  static String path = "/ranks";

  final GlobalKey<NavigatorState> parentKey;

  RankDetailRoute({required this.parentKey});

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
        return const RankDetailPage();
      },
    );
  }
}
