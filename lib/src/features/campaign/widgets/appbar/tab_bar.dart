import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/theme.dart';

class CampaignTabBar extends StatelessWidget with PreferredSizeWidget {
  final Size size;
  final List<Widget> tabs;
  final bool hidden;

  const CampaignTabBar({Key? key, required this.size, required this.tabs, this.hidden = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    if (hidden) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
            width: 2,
          ),
        ),
      ),
      child: TabBar(
        labelColor: theme.primary,
        labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        unselectedLabelColor: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
        indicatorColor: theme.primary,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => hidden ? Size.zero : size;
}
