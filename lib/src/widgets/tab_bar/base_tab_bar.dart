import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

class BaseTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final bool hidden;
  final Border? border;
  final Decoration? indicator;
  final double? width;

  const BaseTabBar({
    Key? key,
    required this.tabs,
    this.hidden = false,
    this.border,
    this.indicator,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    if (hidden) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: border,
      ),
      child: SizedBox(
        width: width,
        child: TabBar(
          indicator: indicator,
          labelColor: theme.primary,
          labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          unselectedLabelColor: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
          indicatorColor: theme.primary,
          tabs: tabs,
        ),
      ),
    );
  }
}
