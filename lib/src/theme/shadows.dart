import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Shadows {
  static final List<BoxShadow> elevation1 = [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 3.r,
      spreadRadius: 1.r,
    ),
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 2.r,
      spreadRadius: 0.r,
    )
  ];

  static final List<BoxShadow> elevation2 = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 6.r,
      spreadRadius: 2.r,
    ),
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 2.r,
      spreadRadius: 0.r,
    )
  ];

  static final List<BoxShadow> elevation3 = [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 3.r,
      spreadRadius: 0.r,
    ),
    BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 8.r,
      spreadRadius: 3.r,
    )
  ];

  static final List<BoxShadow> elevation4 = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 3.r,
      spreadRadius: 0.r,
    ),
    BoxShadow(
      offset: const Offset(0, 6),
      blurRadius: 10.r,
      spreadRadius: 4.r,
    )
  ];

  static final List<BoxShadow> elevation5 = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 4.r,
      spreadRadius: 0.r,
    ),
    BoxShadow(
      offset: const Offset(0, 6),
      blurRadius: 10.r,
      spreadRadius: 6.r,
    )
  ];
}
