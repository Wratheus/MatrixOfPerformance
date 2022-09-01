import 'package:flutter/material.dart';

import '../../feature/pages/login_page/login_page.dart';
import '../../feature/pages/main_management_page/main_management_page.dart';
import '../../feature/pages/registration_page/registration_page.dart';

part './colors.dart';

List<Widget> pageList = <Widget>[ // navigation pages list
  const MainManagementPage(), // Drawer page 1..
  LoginPage(), // page 2
  LoginPage(), // page 3
  RegistrationPage(), // page 4
];
List<String> groupValues = ['ratings', 'group_2', 'team_4'];

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