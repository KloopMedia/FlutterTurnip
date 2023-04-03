import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_drawer.dart';
import 'bottom_nav_bar_item_with_location.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  final Widget child;
  final List<BottomNavBarItemWithLocation> tabs;

  const ScaffoldWithBottomNavBar({
    Key? key,
    required this.tabs,
    required this.child,
  }) : super(key: key);

  @override
  State<ScaffoldWithBottomNavBar> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<ScaffoldWithBottomNavBar> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
