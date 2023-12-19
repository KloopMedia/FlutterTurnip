import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/privacy_policy/view/privacy_policy_page.dart';

class PrivacyPolicyRoute {
  static String name = 'privacy-policy';

  static String path = "/privacy_policy";

  final GlobalKey<NavigatorState> parentKey;

  PrivacyPolicyRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        return const PrivacyPolicyPage();
      },
    );
  }
}
