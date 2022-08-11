import 'dart:ui';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  ResponsiveLayout({
    required this.mobileBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
  static bool desktopPlatformSizeCheck(){ // check method if platform is Desktop or Android
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    return (physicalWidth < 1000) ? false : true; // if desktop return false
  }
}
