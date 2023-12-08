import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/view/settings_page.dart';
import 'package:go_router/go_router.dart';

class SettingsRoute {
  static String name = 'settings';

  static String path = "/campaign/:cid/settings";

  final GlobalKey<NavigatorState> parentKey;

  SettingsRoute({required this.parentKey});

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
        return SettingsPage();
      },
    );
  }
}
