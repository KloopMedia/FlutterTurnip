import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

import 'chain_icon.dart';
import 'chain_sides.dart';
import 'lesson_icon.dart';
import 'types.dart';

class ChainRow extends StatelessWidget {
  final int index;
  final String title;
  final ChainInfoStatus status;
  final ChainPosition position;
  final void Function()? onTap;

  const ChainRow({
    Key? key,
    required this.title,
    required this.status,
    required this.index,
    required this.position,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final isEven = index % 2 == 0;

    final completeLineColor = theme.isLight ? const Color(0xFF2754F3) : const Color(0xFF7694FF);
    final notStartedLineColor = theme.isLight ? const Color(0xFFE1E3E3) : theme.neutral20;

    final lineColor =
        (status == ChainInfoStatus.complete) ? completeLineColor : notStartedLineColor;

    final dashWidth = context.isSmall ? 10.0 : 16.0;
    final dashSpace = context.isSmall ? 10.0 : 12.0;
    final strokeWidth = context.isSmall ? 5.0 : 7.0;

    final style = PaintStyle(
      color: lineColor,
      dashWidth: dashWidth,
      dashSpace: dashSpace,
      strokeWidth: strokeWidth,
    );

    final notStartedColor = theme.isLight ? theme.neutral90 : theme.neutralVariant40;
    final activeColor = theme.isLight ? theme.neutral40 : theme.neutral70;

    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: status == ChainInfoStatus.notStarted ? notStartedColor : activeColor,
    );

    void Function()? _onTap() {
      if (status == ChainInfoStatus.notStarted) {
        return null;
      }
      return onTap;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Align(
          alignment: isEven ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120.0),
            child: GestureDetector(
              onTap: _onTap(),
              child: Text(
                title,
                style: titleTextStyle,
                textAlign: isEven ? TextAlign.right : TextAlign.left,
              ),
            ),
          ),
        ),
        Align(
          alignment: isEven ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: _onTap(),
              child: LessonIcon(
                lessonNum: index,
                status: status,
              ),
            ),
          ),
        ),
        ChainSide(
          style: style,
          isEven: isEven,
          position: position,
        ),
        ChainRowIcon(position: position, isEven: isEven),
      ],
    );
  }
}
