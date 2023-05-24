import 'package:flutter/material.dart';

import 'chain_lines.dart';

class ChainSide extends StatelessWidget {
  final PaintStyle style;
  final bool even;

  const ChainSide({
    Key? key,
    required this.style,
    required this.even,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (even) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 60.0),
          Expanded(
            child: CustomPaint(
              size: const Size(0.0, 0.0),
              painter: StraightLine(style: style),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomPaint(
              size: const Size(50, 120),
              painter: CurveLine.right(style: style),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomPaint(
              size: const Size(50, 120),
              painter: CurveLine.left(style: style),
            ),
          ),
          Expanded(
            child: CustomPaint(
              size: const Size(0.0, 0.0),
              painter: StraightLine(style: style),
            ),
          ),
          const SizedBox(width: 60.0),
        ],
      );
    }
  }
}
