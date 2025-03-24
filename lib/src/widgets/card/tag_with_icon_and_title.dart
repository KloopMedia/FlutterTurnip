import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../widgets.dart';

class TagWithIconAndTitle extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final Color? backgroundColor;
  final dynamic icon;

  const TagWithIconAndTitle(
    this.text, {
    super.key,
    this.backgroundColor,
    this.fontColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final _fontColor = theme.isLight ? const Color(0xFF5E80FB) : const Color(0xFF9BB1FF);
    final _backgroundColor = theme.isLight ? const Color(0xFFF8FAFF) : const Color(0xFF61626B);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Align(
          child: CardChip(
            text,
            fontColor: fontColor ?? _fontColor,
            backgroundColor: backgroundColor ?? _backgroundColor,
            leftPadding: 40,
            verticalPadding: 5,
          ),
        ),
        Align(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor ?? _backgroundColor,
            ),
            padding: const EdgeInsets.all(9),
            child: icon,
          ),
        ),
      ],
    );
  }
}
