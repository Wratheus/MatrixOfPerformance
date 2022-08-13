import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';

import 'package:flutter_matrix_of_skills/src/feature/responsive/mobile_body.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/responsive_layout.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/desktop_body.dart';




void main() {
  App.initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Matrix of performance App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        backgroundColor: Colors.black12
      ),
      home: const ResponsiveLayout(
        desktopBody: DesktopScaffold(),
        mobileBody: MobileScaffold(),
      )
    );
  }
}
