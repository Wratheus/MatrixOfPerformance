import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_stateful_button/template_button.dart';


class TemplateButton1 extends StatelessWidget with TemplateButton {
  final String title;
  const TemplateButton1({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: whiteTextColor
        ),
      ),
    );
  }
}
