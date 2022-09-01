// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';

import '../../../../../core/constants/constants.dart';

class GroupManagementDialog extends StatelessWidget {
  String label;
  GroupManagementDialog({Key? key, required this.label}) : super(key: key);
  // TODO: create for loop textfields for sql
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text("🧵 ", style: darkTextColor),
        content: Column(
          children: [
            Text(" ", style: darkTextColor),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("", style: darkTextColor),
            onPressed: () => {},
          )
        ]
    );
  }
}
