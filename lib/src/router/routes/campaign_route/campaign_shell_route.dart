import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/campaign/widgets/campaign_page_scaffold.dart';
import 'package:gigaturnip/src/widgets/tab_with_location.dart';
import 'package:go_router/go_router.dart';

import 'campaign_available_route.dart';
import 'campaign_user_route.dart';

class CampaignShellRoute {
  final GlobalKey<NavigatorState> navigatorKey;

  CampaignShellRoute({required this.navigatorKey});

  ShellRoute get route {
    return ShellRoute(
      navigatorKey: navigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final tabs = [
          TabWithLocation(
            initialLocation: CampaignAvailableRoute.path,
            label: context.loc.available_campaigns,
          ),
          TabWithLocation(
            initialLocation: CampaignUserRoute.path,
            label: context.loc.campaigns,
          ),
        ];

        return CampaignPageScaffold(
          tabs: tabs,
          child: child,
        );
      },
      routes: [
        CampaignAvailableRoute(parentKey: navigatorKey).route,
        CampaignUserRoute(parentKey: navigatorKey).route,
      ],
    );
  }
}
