import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';
import 'package:flutter_matrix_of_skills/src/core/services/custom_scroll_behavior.dart';

import 'src/core/services/app_theme.dart';
import 'src/feature/pages/login_page/login_page.dart';
import 'src/feature/responsive/desktop_body.dart';
import 'src/feature/responsive/mobile_body.dart';
import 'src/feature/responsive/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await App.initApp();
  App.session = await App.supaBaseController.sessionSignIn();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
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
      home: (App.session == true) ?
      const ResponsiveLayout(
          desktopBody: DesktopScaffold(),
          mobileBody: MobileScaffold()
      ) : LoginPage()
    );
  }
}