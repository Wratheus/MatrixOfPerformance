import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';

import 'src/feature/pages/login_page/login_page.dart';




void main() {
  App.initApp();
  SystemChrome.setPreferredOrientations([ //remove mobile flip
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
      home: const LoginPage()
    );
  }
}
