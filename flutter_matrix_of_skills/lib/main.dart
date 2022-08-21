import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';

import 'src/core/constants/constants.dart';
import 'src/feature/pages/login_page/login_page.dart';




void main() {
  App.initApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Matrix of performance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: MyColors.mainInnerColor,
          secondary: MyColors.mainBeige,
        ),
      ),
      home: LoginPage()
    );
  }
}