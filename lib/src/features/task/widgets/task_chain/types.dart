import 'package:flutter/material.dart';

enum ChainInfoStatus {
  complete,
  active,
  returned,
  notStarted,
}

enum ChainPosition { start, middle, end }

class Position {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const Position({this.top, this.bottom, this.left, this.right});
}

class PaintStyle {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  PaintStyle({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  PaintStyle copyWith({
    Color? color,
    double? dashWidth,
    double? dashSpace,
    double? strokeWidth,
  }) {
    return PaintStyle(
      color: color ?? this.color,
      dashWidth: dashWidth ?? this.dashWidth,
      dashSpace: dashSpace ?? this.dashSpace,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
