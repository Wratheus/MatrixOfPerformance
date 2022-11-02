import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/desktop_body.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/mobile_body.dart';

class ResponsiveLayout extends StatelessWidget {

  const ResponsiveLayout({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!Platform.isWindows) {
          return const MobileScaffold();
        } else {
          return const DesktopScaffold();
        }
      },
    );
  }
  static bool desktopPlatformSizeCheck(){ // check method if platform is Desktop or Android
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    return (physicalWidth < 1200) ? false : true; // if desktop return false
  }
}
