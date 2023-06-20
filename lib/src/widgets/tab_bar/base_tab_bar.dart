import 'package:flutter/material.dart';

import 'package:gigaturnip/src/theme/index.dart';

double calculateTabWidth(BuildContext context) {
  final deviceWidth = MediaQuery.of(context).size.width;
  if (context.isExtraLarge) {
    return deviceWidth / 3;
  } else if (context.isLarge) {
    return deviceWidth / 2;
  } else {
    return double.infinity;
  }
}

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

    return Container(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: width,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomLeft,
          children: [
            Container(decoration: BoxDecoration(border: border)),
            TabBar(
              indicator: indicator,
              labelColor: theme.primary,
              labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              unselectedLabelColor: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
              indicatorColor: theme.primary,
              tabs: tabs,
            )
          ],
        ),
      ),
    );
  }
}
