import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

// ignore: must_be_immutable
class SampleTextField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final bool hideText;
  final Color borderColor;
  final TextStyle textColor;
  final double width;
  final TextInputType? inputType;
  final List<TextInputFormatter>? textInputFormatters;
  const SampleTextField({Key? key, required this.textController, required this.labelText, required this.hideText, required this.borderColor, required this.textColor, required this.width, this.inputType = TextInputType.text, this.textInputFormatters}) : super(key: key);

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
