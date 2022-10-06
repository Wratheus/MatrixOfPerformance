import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

// ignore: must_be_immutable
class SampleTextField extends StatelessWidget {
  TextEditingController textController;
  String labelText;
  bool hideText;
  Color borderColor;
  TextStyle textColor;
  double width;
  TextInputType? inputType;
  List<TextInputFormatter>? textInputFormatters;
  SampleTextField({Key? key, required this.textController, required this.labelText, required this.hideText, required this.borderColor, required this.textColor, required this.width, this.inputType = TextInputType.text, this.textInputFormatters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        keyboardType: inputType,
        inputFormatters: textInputFormatters,
        cursorColor: MyColors.mainBeige,
        obscureText: hideText,
        controller: textController,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            iconColor: MyColors.mainBeige,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.mainBeige, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.mainBeige, width: 0.0),
            ),
            border: const OutlineInputBorder(),
            labelText: labelText,
            labelStyle: whiteTextColor,

          ),
        style: textColor,
      ),
    );
  }
}
