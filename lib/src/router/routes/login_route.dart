import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/login/view/login_page.dart';
import 'package:go_router/go_router.dart';

class LoginRoute {
  static String name = 'login';

  static String path = "/login";

  final GlobalKey<NavigatorState> parentKey;

  LoginRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        final query = {...state.queryParams};
        final id = query['campaigns'];
        return LoginPage(campaignId: id);
      },
    );
  }
}
