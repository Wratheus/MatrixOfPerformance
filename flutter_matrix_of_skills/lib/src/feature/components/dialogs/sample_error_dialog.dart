// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/page_transition.dart';

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
            if (route != null){Navigator.pushReplacement(context, SlideRightRoute(page: route!))}
          },
        )
      ],
      title: Text("Error 🥺", style: whiteTextColor, textAlign: TextAlign.center,),
      content: Text(errorMessage, style: whiteTextColor, textAlign: TextAlign.center),
    );
  }
}
