import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task/view/available_task_page.dart';
import 'package:go_router/go_router.dart';

class TaskAvailableRoute {
  static String name = 'taskAvailable';

  static String path = "/campaign/:cid/task/available";

  final GlobalKey<NavigatorState> parentKey;
  final FutureOr<String?> Function(BuildContext context, GoRouterState state)? redirect;


  TaskAvailableRoute({required this.parentKey, this.redirect});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      redirect: redirect,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.params['cid'];
        if (id == null) {
          return Text(context.loc.unknown_page);
        }
        return AvailableTaskPage(campaignId: int.parse(id));
      },
    );
  }
}
