import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign_management/view/campaing_management_page.dart';
import 'package:go_router/go_router.dart';

class ChainRoute {
  static String name = 'chain';

  static String path = "/campaign/:cid/chains";

  final GlobalKey<NavigatorState> parentKey;

  ChainRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['cid'] ?? '';

        final campaignId = int.tryParse(id);
        if (campaignId == null) {
          return const Text('Error: Failed to parse id');
        }
        return const CampaignManagementPage();
      },
    );
  }
}
