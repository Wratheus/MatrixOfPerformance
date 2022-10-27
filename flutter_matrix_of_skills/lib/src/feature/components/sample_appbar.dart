import 'package:flutter/material.dart';

class SampleAppbar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final Color backgroundColor;
  final TextStyle textColor;
  const SampleAppbar({Key? key, required this.title, required this.backgroundColor, required this.textColor}) : super(key: key);

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
