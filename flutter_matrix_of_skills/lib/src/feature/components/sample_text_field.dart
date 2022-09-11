import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

// ignore: must_be_immutable
class SampleTextField extends StatefulWidget {
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
  State<SampleTextField> createState() => _SampleTextFieldState();
}

class _SampleTextFieldState extends State<SampleTextField> {
  String textControllerText = '';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        keyboardType: widget.inputType,
        inputFormatters: widget.textInputFormatters,
        cursorColor: MyColors.mainBeige,
        obscureText: widget.hideText,
        controller: widget.textController,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.mainBeige, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.mainBeige, width: 0.0),
            ),
            border: const OutlineInputBorder(),
            labelText: widget.labelText,
            labelStyle: whiteTextColor,

          ),
        style: widget.textColor,
        onSubmitted: (text) => {
          setState(() {
            textControllerText = widget.textController.text;
          }
          )
        }
      ),
    );
  }
}
