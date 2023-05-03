import 'package:flutter/material.dart';
import 'chain_lines.dart';

Widget rightSide = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(width: 40.0),
    straightLine,
    Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: CustomPaint(
        size: const Size(40, 120),
        painter: CurveRightLine(),
      ),
    ),
  ],
);

Widget leftSide =  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: CustomPaint(
        size: const Size(40, 120),
        painter: CurveLeftLine(),
      ),
    ),
    straightLine,
    const SizedBox(width: 40.0),
  ],
);