import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(69, 123, 157, 1);
const Color secondaryColor = Color.fromRGBO(168, 210, 219, 1);

final theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
  // fontFamily: 'Roboto',
  textTheme: ThemeData.light().textTheme.copyWith(
        titleSmall: const TextStyle(
          fontFamily: 'Open-Sans',
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
        titleMedium: const TextStyle(
          fontFamily: 'Open-Sans',
          fontWeight: FontWeight.w400,
          fontSize: 25,
        ),
        // double tasks header

        titleLarge: const TextStyle(
          fontFamily: 'Open-Sans',
          fontWeight: FontWeight.w500,
          fontSize: 27,
          color: Colors.white,
        ),
        headlineLarge: const TextStyle(
          fontFamily: 'Open-Sans',
          fontWeight: FontWeight.w400,
          fontSize: 23,
          color: Colors.black87,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Open-Sans',
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.white,
        ),
        headlineSmall: const TextStyle(
          fontFamily: 'Open-Sans',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
  ),
);