import 'package:flutter/material.dart';

import '../widgets.dart';

class TagWithIconAndTitle extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final Color? backgroundColor;
  final dynamic icon;

  const TagWithIconAndTitle(
    this.text, {
    Key? key,
    this.backgroundColor,
    this.fontColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fontColor = const Color(0xFF5E80FB);
    final _backgroundColor = const Color(0xFFF8FAFF);

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
