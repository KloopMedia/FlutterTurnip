import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/filter_button.dart';

class FilterRoute {
  static String name = 'filter';

  static String path = "/filter";

  final GlobalKey<NavigatorState> parentKey;

  FilterRoute({required this.parentKey});

  GoRoute get route {
    return GoRoute(
      parentNavigatorKey: parentKey,
      name: name,
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        return const FilterPage();
      },
    );
  }
}