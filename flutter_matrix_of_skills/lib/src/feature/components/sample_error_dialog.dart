// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import '../../core/constants/constants.dart';

class SampleErrorDialog extends StatelessWidget {
  String errorMessage;
  SampleErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      scrollController: ScrollController(),
      actions: [
        CupertinoDialogAction(
          child: Text("OK", style: darkTextColor),
          onPressed: () => Navigator.pop(context),
        )
      ],
      title: Text("🥺 Error", style: darkTextColor),
      content: Text(errorMessage, style: darkTextColor),
    );
  }
}
