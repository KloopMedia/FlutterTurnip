import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign_detail/view/campaign_detail_page.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class CampaignDetailRoute {
  static String name = 'campaignDetail';

  static String path = "/campaign/:cid/about";

  final GlobalKey<NavigatorState> parentKey;

  CampaignDetailRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final campaign = state.extra;
        final cid = state.pathParameters['cid'] ?? '';

        final campaignId = int.parse(cid);

        if (campaign != null && campaign is Campaign) {
          return CampaignDetailPage(
            key: ValueKey(cid),
            campaignId: campaignId,
            campaign: campaign,
          );
        }
        return CampaignDetailPage(key: ValueKey(cid), campaignId: campaignId);
      },
    );
  }
}
