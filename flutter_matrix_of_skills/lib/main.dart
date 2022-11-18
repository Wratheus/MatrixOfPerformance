import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';
import 'package:flutter_matrix_of_skills/src/core/services/custom_scroll_behavior.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/desktop_body.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'src/core/services/app_theme.dart';
import 'src/feature/pages/login_page/login_page.dart';
import 'src/feature/responsive/responsive_layout.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  App.sessionSignIn = await App.supaBaseController.sessionSignIn();
  runApp(const MyApp());
  if(Platform.isWindows) DesktopScaffold.setUpWindowsEnvironment();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Matrix of performance App',
      theme: AppTheme.themeData,
      home: (App.sessionSignIn) ?
      const ResponsiveLayout() : LoginPage()
    );
  }
}

