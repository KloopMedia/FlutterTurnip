import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/view/user_campaign_page.dart';
import 'package:go_router/go_router.dart';

class CampaignUserRoute {
  static String name = "userCampaign";

  static String path = "/campaign/user";

  final GlobalKey<NavigatorState> parentKey;

  CampaignUserRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        return const UserCampaignPage();
      },
    );
  }
}
