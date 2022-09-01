// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

class SampleErrorDialog extends StatelessWidget {
  String errorMessage;
  Widget? route;
  SampleErrorDialog({Key? key, required this.errorMessage, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      scrollController: ScrollController(),
      actions: [
        CupertinoDialogAction(
          child: Text("OK", style: darkTextColor),
          onPressed: () => {
            if (route == null) {Navigator.pop(context)},
            if (route != null){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route!))}
          },
        )
      ],
      title: Text("🥺 Error", style: darkTextColor),
      content: Text(errorMessage, style: darkTextColor),
    );
  }
}
