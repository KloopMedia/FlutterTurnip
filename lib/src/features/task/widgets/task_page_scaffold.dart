import 'package:flutter/material.dart';
import 'package:gigaturnip/src/helpers/app_drawer.dart';
import 'package:gigaturnip/src/router/routes/campaign_route.dart';
import 'package:go_router/go_router.dart';

class TaskPageScaffold extends StatefulWidget {
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  const TaskPageScaffold({
    Key? key,
    required this.tabs,
    required this.child,
  }) : super(key: key);

  @override
  State<TaskPageScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<TaskPageScaffold> {
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  void _redirectToCampaignPage(BuildContext context) {
    final routeState = GoRouterState.of(context);
    context.goNamed(CampaignRoute.name, queryParams: routeState.queryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            _redirectToCampaignPage(context);
          },
        ),
      ),
      endDrawer: const AppDrawer(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  final String initialLocation;

  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);
}
