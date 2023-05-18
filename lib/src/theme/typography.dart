import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final textTheme = Typography.englishLike2021.copyWith(
  displayLarge: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
  ),
  displayMedium: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22,
  ),
  displaySmall: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  ),
  headlineMedium: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  ),
  headlineSmall: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  ),
  bodyLarge: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  ),
  bodyMedium: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  ),
).apply(fontSizeFactor: 1.sp);
