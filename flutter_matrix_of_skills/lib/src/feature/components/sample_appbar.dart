import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SampleAppbar extends StatelessWidget with PreferredSizeWidget{
  String title;
  Color backgroundColor;
  TextStyle textColor;
  SampleAppbar({Key? key, required this.title, required this.backgroundColor, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title, style: textColor),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
