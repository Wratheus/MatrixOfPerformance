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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors.customBlack.withOpacity(0.35),
              blurRadius: 4,
            ),
          ],
        ),
        child: TextField(
          enableSuggestions: false,
          keyboardType: inputType,
          inputFormatters: textInputFormatters,
          cursorColor: MyColors.mainBeige,
          obscureText: hideText,
          controller: textController,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: textController.clear,
                icon: CircleAvatar(backgroundColor: MyColors.mainBeige.withOpacity(0.05), child: const Icon(Icons.clear, size: 14, color: MyColors.mainBeige,))),
              iconColor: MyColors.mainBeige,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: MyColors.mainBeige.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(8.0)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: MyColors.mainBeige.withOpacity(1)),
                  borderRadius: BorderRadius.circular(8.0)
              ),
              labelText: labelText,
              labelStyle: whiteTextColor,

            ),
          style: textColor,
        ),
      ),
    );
  }
}
