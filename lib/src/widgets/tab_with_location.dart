import 'package:flutter/material.dart';

class TabWithLocation extends Tab {
  final String initialLocation;

  const TabWithLocation({
    super.key,
    required this.initialLocation,
    Widget? icon,
    String? label,
  }) : super(icon: icon, text: label);
}
