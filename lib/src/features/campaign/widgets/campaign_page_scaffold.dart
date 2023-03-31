import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/features/campaign/widgets/appbar/tag_bar.dart';
import 'package:go_router/go_router.dart';

import 'appbar/search_bar.dart';

class CampaignPageScaffold extends StatefulWidget {
  final Widget child;
  final List<ScaffoldTabItem> tabs;

  const CampaignPageScaffold({
    Key? key,
    required this.tabs,
    required this.child,
  }) : super(key: key);

  @override
  State<CampaignPageScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<CampaignPageScaffold> {
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
    return DefaultTabController(
      length: widget.tabs.length,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 125.h,
            flexibleSpace: Padding(
              padding: EdgeInsets.all(12.h),
              child: SizedBox(
                height: 110.h,
                child: Column(
                  children: [
                    SearchBar(),
                    SizedBox(height: 15.h),
                    TagBar(),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              unselectedLabelColor: Theme.of(context).colorScheme.outlineVariant,
              indicatorColor: Theme.of(context).colorScheme.primary,
              onTap: (index) => _onItemTapped(context, index),
              tabs: widget.tabs,
            ),
          ),
          body: widget.child,
        ),
      ),
    );
  }
}

class ScaffoldTabItem extends Tab {
  final String initialLocation;

  const ScaffoldTabItem({
    super.key,
    required this.initialLocation,
    Widget? icon,
    String? label,
  }) : super(icon: icon, text: label);
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  final String initialLocation;

  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);
}
