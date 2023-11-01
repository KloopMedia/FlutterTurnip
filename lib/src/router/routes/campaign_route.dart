import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/view/campaign_page.dart';
import 'package:go_router/go_router.dart';

class CampaignRoute {
  static String name = 'campaigns';

  static String path = "/";

  final GlobalKey<NavigatorState> parentKey;

  CampaignRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        return const CampaignPage();
      },
    );
  }
}
