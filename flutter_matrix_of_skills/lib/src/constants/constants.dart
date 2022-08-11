import 'package:flutter/material.dart';

import '../pages/main_management_page.dart';

part './colors.dart';

List<Widget> pageList = <Widget>[ // navigation pages list
  const MainManagementPage(),
  Container(color: Colors.red, child: Center(child: Text("Welcome to the page 2", style: drawerTextColor))),
  Container(color: Colors.blue, child: Center(child: Text("Welcome to the page 3", style: drawerTextColor))),
  Container(color: Colors.purpleAccent, child: Center(child: Text("Welcome to the page 4", style: drawerTextColor))),
];
var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text('Matrix of Performance', style: AppBarTextColor),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var AppBarTextColor = TextStyle(
  color: Colors.grey[200],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);