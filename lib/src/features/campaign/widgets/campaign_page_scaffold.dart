import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:gigaturnip/src/widgets/tab_with_location.dart';
import 'package:go_router/go_router.dart';

class CampaignPageScaffold extends StatefulWidget {
  final Widget child;
  final List<TabWithLocation> tabs;

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
    final theme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: widget.tabs.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.background,
          drawer: Drawer(),
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: theme.isLight ? theme.neutral30 : theme.neutral90,
            ),
            backgroundColor: theme.surface,
            title: Text(
              context.loc.campaigns,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: theme.isLight ? theme.neutral30 : theme.neutral90,
              ),
            ),
            actions: [
              // TODO: Replace icons
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded))
            ],
            // flexibleSpace: Padding(
            //   padding: EdgeInsets.all(12.h),
            //   child: SizedBox(
            //     height: 110.h,
            //     child: Column(
            //       children: [
            //         // SearchBar(),
            //         SizedBox(height: 15.h),
            //         TagBar(),
            //       ],
            //     ),
            //   ),
            // ),
            bottom: TabBar(
              labelColor: theme.primary,
              labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              unselectedLabelColor: theme.outlineVariant,
              indicatorColor: theme.primary,
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

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  final String initialLocation;

  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);
}
