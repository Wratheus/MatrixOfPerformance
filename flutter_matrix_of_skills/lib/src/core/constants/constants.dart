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

var whiteTextColor = const TextStyle(
  color: Colors.white,
);
var darkTextColor = const TextStyle(
  color: MyColors.customDeepPurple,
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);