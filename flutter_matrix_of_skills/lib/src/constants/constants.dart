import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/pages/login_page.dart';

import '../pages/main_management_page.dart';

part './colors.dart';

List<Widget> pageList = <Widget>[ // navigation pages list
  const MainManagementPage(),
  const LoginPage(),
  Container(color: Colors.blue, child: Center(child: Text("Welcome to the page 3", style: drawerTextColor))),
  Container(color: Colors.purpleAccent, child: Center(child: Text("Welcome to the page 4", style: drawerTextColor))),
];
var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text('Matrix of Performance', style: appBarTextColor),
  centerTitle: false,
);
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