import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// custom scroll behavior to swipe left and right directions correctly with two scroll views
class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}