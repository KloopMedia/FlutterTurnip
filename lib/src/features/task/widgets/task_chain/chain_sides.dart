import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/task_stage_chain_page.dart';

import 'chain_lines.dart';

class ChainSide extends StatelessWidget {
  final PaintStyle style;
  final bool isEven;
  final ChainPosition position;

  const ChainSide({
    Key? key,
    required this.style,
    required this.isEven,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alignment = isEven ? Alignment.centerRight : Alignment.centerLeft;
    final curveLine = isEven ? CurveLine.right(style: style) : CurveLine.left(style: style);

    const curveWidth = 50.0;
    const offset = curveWidth + 5;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          left: offset,
          right: offset,
          child: CustomPaint(
            size: const Size(double.infinity, 0.0),
            painter: StraightLine(style: style),
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
              painter: StraightLine(style: style),
            ),
          ),
      ],
    );
  }
}
