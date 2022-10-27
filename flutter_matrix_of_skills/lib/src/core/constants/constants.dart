import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/graph_view_page.dart';

import '../../feature/pages/main_management_page/main_management_page.dart';

part './colors.dart';

const List<Color> chartColors = [
  Color.fromRGBO(75, 135, 185, 1),
  Color.fromRGBO(192, 108, 132, 1),
  Color.fromRGBO(246, 114, 128, 1),
  Color.fromRGBO(248, 177, 149, 1),
  Color.fromRGBO(116, 180, 155, 1),
  Color.fromRGBO(0, 168, 181, 1),
  Color.fromRGBO(73, 76, 162, 1),
  Color.fromRGBO(255, 205, 96, 1),
  Color.fromRGBO(255, 240, 219, 1),
  Color.fromRGBO(238, 238, 238, 1)
];

List<Widget> pageList = <Widget>[ // navigation pages list
  const TableManagementPage(), // Drawer page 1..
  const GraphViewPage(), // page 2
];
bool isDigit(String str){
  RegExp intRegExp = RegExp(r"^\d+$");
  return intRegExp.hasMatch(str);
}
double longestName(List<dynamic> data){
  int longestName = data[0]['name'].length;
  for (var element in data) {
    if (element['name'].length > longestName) longestName = element['name'].length;
  }
  return longestName.toDouble();
}
double maxValue(List<dynamic> data){
  int maxValue = 0;
  for (var element in data) {
    List values = (element as Map).values.toSet().toList().sublist(2);
    final int tmpMax = values.cast<int>().reduce(max);
    if (tmpMax > maxValue) maxValue = tmpMax;
  }
  if(maxValue < 10) maxValue = 10;
  return maxValue.toDouble();
}
var whiteTextColor = const TextStyle(
  color: Colors.white,
);
var chartsTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20
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