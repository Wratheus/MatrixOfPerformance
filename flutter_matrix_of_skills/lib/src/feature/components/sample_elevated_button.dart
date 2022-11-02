import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const SampleElevatedButton({Key? key, required this.onPressed, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2, color: MyColors.mainBeige.withOpacity(0.7)),
        backgroundColor: MyColors.mainOuterColor, //button's fill color
        textStyle: whiteTextColor, //specify the button's text TextStyle
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8.0, left: 8.0), //specify the button's Padding
        minimumSize: const Size(150, 40), //specify the button's first: width and second: height
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // set the buttons shape. Make its birders rounded etc
        enabledMouseCursor: MouseCursor.defer, //used to construct ButtonStyle.mouseCursor
        disabledMouseCursor: MouseCursor.uncontrolled, //used to construct ButtonStyle.mouseCursor
        visualDensity: const VisualDensity(horizontal: 0.0, vertical: 0.0), //set the button's visual density
        tapTargetSize: MaterialTapTargetSize.padded, // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
        animationDuration: const Duration(milliseconds: 100), //the buttons animations duration
        enableFeedback: true, //to set the feedback to true or false
        alignment: Alignment.bottomCenter, //set the button's child Alignment
      ),
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: child
      )
    );
  }
}
