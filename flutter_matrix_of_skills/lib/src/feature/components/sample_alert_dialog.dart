// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

class SampleAlertDialog extends StatelessWidget {
  String alertMessageStr;
  String tittleStr;
  Widget? route;
  SampleAlertDialog({Key? key, required this.alertMessageStr, required this.tittleStr, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.mainInnerColor,
      title: Text("$tittleStr 🧵", style: whiteTextColor),
      content: Text(alertMessageStr, style: whiteTextColor),
      actions: [
        TextButton(
          child: Text("OK", style: whiteTextColor),
          onPressed: ()=> {
            Navigator.of(context).pop(),
            if (route != null){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route!))}
          }
        )
      ],
    );
  }
}
