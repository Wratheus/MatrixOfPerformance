import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/desktop_body.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/mobile_body.dart';

class ResponsiveLayout extends StatelessWidget {

  const ResponsiveLayout({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isWindows) {
      Widget layout = MobileScaffold();
      return layout;
    } else {
      Widget layout = DesktopScaffold();
      return layout;
    }
  }
}
