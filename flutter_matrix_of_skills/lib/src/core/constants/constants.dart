import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/graph_view_page.dart';

import '../../feature/pages/login_page/login_page.dart';
import '../../feature/pages/main_management_page/main_management_page.dart';
import '../../feature/pages/registration_page/registration_page.dart';

part './colors.dart';

List<Widget> pageList = <Widget>[ // navigation pages list
  const TableManagementPage(), // Drawer page 1..
  const GraphViewPage(), // page 2
  LoginPage(), // page 3
  RegistrationPage(), // page 4
];
bool isDigit(String str){
  RegExp intRegExp = RegExp(r"^\d+$");
  return intRegExp.hasMatch(str);
}

var whiteTextColor = const TextStyle(
  color: Colors.white,
);
var darkTextColor = const TextStyle(
  color: MyColors.customDeepPurple,
);
var greyTextColor = TextStyle(
  color: Colors.grey.shade400,
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

const Widget appIcon = Center(child: Icon(
Icons.architecture,
size: 128,
color: MyColors.mainBeige,
));