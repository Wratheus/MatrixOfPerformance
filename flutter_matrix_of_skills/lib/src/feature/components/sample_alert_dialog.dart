// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_appbar.dart';

class SampleAlertDialog extends StatelessWidget {
  String alertMessageStr;
  String appBarStr;
  Widget? routePage;
  SampleAlertDialog({Key? key, required this.alertMessageStr, required this.appBarStr, this.routePage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainCanvas,
      appBar: SampleAppbar(title: appBarStr, backgroundColor: MyColors.mainOuterColor, textColor: whiteTextColor),
      body: AlertDialog(
          title: Text(alertMessageStr,
            style: whiteTextColor,
          ),
        backgroundColor: MyColors.mainInnerColor,
        actions: <Widget>[
          TextButton(
            child: Text("OK",
              style: whiteTextColor,
            ),
            onPressed: ()=>{
              if(routePage == null){
                Navigator.of(context).pop()
              }else {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => routePage!)), // if route page was provided - go to
              }
            },
          ),
        ],
      ),
    );
  }
}
