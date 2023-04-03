import 'package:flutter/material.dart';

class BottomNavBarItemWithLocation extends BottomNavigationBarItem {
  final String initialLocation;

  const BottomNavBarItemWithLocation({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);
}
