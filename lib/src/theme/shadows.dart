import 'package:flutter/material.dart';

const _shadowColor1 = Color.fromRGBO(69, 69, 69, 0.1);
const _shadowColor2 = Color.fromRGBO(69, 69, 69, 0.15);

class Shadows {
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1,
      color: _shadowColor1,
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: _shadowColor1,
    )
  ];

  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 2,
      color: _shadowColor1,
    ),
    BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        spreadRadius: 0,
        // color: Color(0x0A454545),
        color: _shadowColor1)
  ];

  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: _shadowColor1,
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 3,
      color: _shadowColor1,
    )
  ];

  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 3,
      spreadRadius: 0,
      color: _shadowColor1,
    ),
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 10,
      spreadRadius: 4,
      color: _shadowColor2,
    )
  ];

  static const List<BoxShadow> elevation5 = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
      color: _shadowColor1,
    ),
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 10,
      spreadRadius: 6,
      color: _shadowColor2,
    )
  ];
}
