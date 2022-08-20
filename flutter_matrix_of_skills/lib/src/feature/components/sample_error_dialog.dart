// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleErrorDialogPage extends StatelessWidget {
  String errorMessage;
  SampleErrorDialogPage({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainCanvas,
      body: Container(
        decoration: const BoxDecoration(
          color: MyColors.mainCanvas,
        ),
        child: Center(
          child: Text(errorMessage,
            style: whiteTextColor,
          ),
        ),
      ),
    );
  }
}
