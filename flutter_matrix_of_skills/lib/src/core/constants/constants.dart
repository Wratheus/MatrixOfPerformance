import 'package:flutter/material.dart';

import '../../feature/pages/login_page/login_page.dart';
import '../../feature/pages/main_management_page/main_management_page.dart';
import '../../feature/pages/registration_page/registration_page.dart';

part './colors.dart';

List<Widget> pageList = <Widget>[ // navigation pages list
  const MainManagementPage(),
  const LoginPage(),
  const RegistrationPage(),
];
var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var appBarTextColor = TextStyle(
  color: Colors.grey[200],
);
var buttonTextColor = TextStyle(
  color: Colors.grey[900],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);