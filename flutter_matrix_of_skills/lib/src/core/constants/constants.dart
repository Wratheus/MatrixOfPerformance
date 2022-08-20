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
List<String> groupValues = ['Ratings', 'group 2', 'group 3'];

List<List<dynamic>> rawValues = [['John', 1, null, 3],['Alex', 3, 4, 3], ['Frank', null, null, 2]];
List<String> skillValues = ['name', 'skill item 1', 'skill item 2', 'skill item 3'];

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
var highlightedTextColor = const TextStyle(
  color: Colors.black54,
  fontSize: 16,
  fontWeight: FontWeight.bold
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);