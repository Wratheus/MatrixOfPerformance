import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';



// ignore: must_be_immutable
class SampleAppbar extends StatelessWidget with PreferredSizeWidget{
  String title;
  SampleAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text(title, style: appBarTextColor),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
