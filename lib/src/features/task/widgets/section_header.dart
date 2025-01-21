import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const SectionHeader(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.only(left: 16, right: 16, bottom: 20),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.isLight ? theme.neutral40 : theme.neutral90,
              ),
        ),
      ),
    );
  }
}
