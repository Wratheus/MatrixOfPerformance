// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/constants/constants.dart';

class SampleElevatedButtonStyleContainer extends StatelessWidget {
  String labelText;
  SampleElevatedButtonStyleContainer({Key? key, required this.labelText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        labelText,
        style: buttonTextColor,
      ),
    );
  }
}
