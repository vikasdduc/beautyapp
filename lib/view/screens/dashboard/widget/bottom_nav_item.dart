import 'package:flutter/material.dart';

BottomNavigationBarItem bottomNavItem(
    BuildContext context, IconData iconData, String label,) {
  return BottomNavigationBarItem(
    icon: Icon(
      iconData,
      // color: color,
    ),
    label: label,
  );
}
