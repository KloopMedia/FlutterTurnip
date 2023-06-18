import 'package:flutter/material.dart';

import 'chain_lines.dart';
import 'types.dart';

class ChainSide extends StatelessWidget {
  final PaintStyle style;
  final PaintStyle endStyle;
  final bool isEven;
  final bool isCollapsed;
  final ChainPosition position;

  const ChainSide({
    Key? key,
    required this.style,
    required this.endStyle,
    required this.isEven,
    required this.isCollapsed,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alignment = isEven ? Alignment.centerRight : Alignment.centerLeft;
    final curveLine = isEven ? CurveLine.right(style: style) : CurveLine.left(style: style);

    const curveWidth = 55.0;
    const offset = curveWidth + 6;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          left: offset,
          right: offset,
          child: CustomPaint(
            size: const Size(double.infinity, 0.0),
            painter: StraightLine(style: style, isCollapsed: false),
          ),
        ),
        Align(
          alignment: alignment,
          child: CustomPaint(
            size: const Size(curveWidth, 120),
            painter: curveLine,
          ),
        ),
        if (position == ChainPosition.end)
          Positioned(
            bottom: 0,
            left: offset,
            right: offset,
            child: CustomPaint(
              size: const Size(double.infinity, 0.0),
              painter: StraightLine(style: endStyle, isCollapsed: isCollapsed),
            ),
          ),
      ],
    );
  }
}
