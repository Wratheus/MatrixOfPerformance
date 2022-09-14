// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class SampleErrorDialog extends StatelessWidget {
  String errorMessage;
  Widget? route;
  SampleErrorDialog({Key? key, required this.errorMessage, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.mainInnerColor,
      actions: [
        TextButton(
          child: Text("OK", style: whiteTextColor),
          onPressed: () => {
            if (route == null) {Navigator.pop(context)},
            if (route != null){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route!))}
          },
        )
      ],
      title: Text("Error 🥺", style: whiteTextColor),
      content: Text(errorMessage, style: whiteTextColor),
    );
  }
}
