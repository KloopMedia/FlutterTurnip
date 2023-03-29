import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              children: const [
                SearchBar(),
              ],
            ),
            bottom: TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
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

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.search,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Кампании, ключевые слова',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    thickness: 2,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  child: Text(
                    'Фильтр',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
