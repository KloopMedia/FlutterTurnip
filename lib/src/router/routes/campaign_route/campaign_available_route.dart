import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/view/available_campaign_page.dart';
import 'package:go_router/go_router.dart';

class CampaignAvailableRoute {
  static String name = "availableCampaign";

  static String path = "/campaign/available";

  final GlobalKey<NavigatorState> parentKey;

  CampaignAvailableRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        return const AvailableCampaignPage();
      },
    );
  }
}
