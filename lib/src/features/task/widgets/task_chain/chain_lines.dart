import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'types.dart';

class StraightLine extends CustomPainter {
  final PaintStyle style;
  final bool isEven;

  const StraightLine({required this.style, required this.isEven});

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0.0;

    final paint = Paint()
      ..color = style.color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = style.strokeWidth
      ..shader = ui.Gradient.linear(
          Offset(startX, startX), Offset(size.width, size.height),
          // (isEven) ? Offset(startX, startX) : Offset(size.width, size.height),
          // (isEven) ? Offset(size.width, size.height) : Offset(startX, startX),
        [
          const Color(0xFF96ADFF),
          const Color(0xFF2754F3)
        ],
      );

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0.0), Offset(startX + style.dashWidth, 0.0), paint);
      startX += style.dashWidth + style.dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

abstract class CurveLine extends CustomPainter {
  final PaintStyle style;

  const CurveLine._({required this.style});

  factory CurveLine.right({required PaintStyle style}) => _CurveRightLine(style: style);

  factory CurveLine.left({required PaintStyle style}) => _CurveLeftLine(style: style);

  (Offset start, Offset control1, Offset control2, Offset end) _calculatePath(Size size);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = style.color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = style.strokeWidth
      ..shader = ui.Gradient.linear(
        const Offset(0.0, 0.0),
        Offset(size.width, size.height),
        // const Offset(0.0, 0.0),
        [
          const Color(0xFF96ADFF),
          const Color(0xFF2754F3)
        ],
      );

    final (startPoint, controlPoint1, controlPoint2, endPoint) = _calculatePath(size);

    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    final dashArray = CircularIntervalList<double>(<double>[style.dashWidth, style.dashSpace]);
    canvas.drawPath(
      dashPath(path, dashArray: dashArray),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _CurveLeftLine extends CurveLine {
  _CurveLeftLine({required PaintStyle style}) : super._(style: style);

  @override
  (Offset, Offset, Offset, Offset) _calculatePath(Size size) {
    var startPoint = Offset(size.width, size.height - 120);
    var controlPoint1 = Offset(0, size.height / 6);
    var controlPoint2 = Offset(0, 5 * size.height / 6);
    var endPoint = Offset(size.width, size.height);

    return (startPoint, controlPoint1, controlPoint2, endPoint);
  }
}

class _CurveRightLine extends CurveLine {
  _CurveRightLine({required PaintStyle style}) : super._(style: style);

  @override
  (Offset, Offset, Offset, Offset) _calculatePath(Size size) {
    var startPoint = Offset(0, size.height - 120);
    var controlPoint1 = Offset(size.width, size.height / 6);
    var controlPoint2 = Offset(size.width, 5 * size.height / 6);
    var endPoint = Offset(0, size.height);

    return (startPoint, controlPoint1, controlPoint2, endPoint);
  }
}
