import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/pages/responsive/responsive_layout.dart';

import './src/pages/responsive/desktop_body.dart';
import './src/pages/responsive/mobile_body.dart';

void main() {
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
      home: ResponsiveLayout(
        desktopBody: const DesktopScaffold(),
        mobileBody: const MobileScaffold(),
      )
    );
  }
}
