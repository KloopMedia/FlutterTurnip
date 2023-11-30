import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/rank/rank_page.dart';


class RankRoute {
  static String name = 'rank';

  static String path = "/rank";

  final GlobalKey<NavigatorState> parentKey;

  RankRoute({required this.parentKey});

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
        return const RankPage();
      },
    );
  }
}
