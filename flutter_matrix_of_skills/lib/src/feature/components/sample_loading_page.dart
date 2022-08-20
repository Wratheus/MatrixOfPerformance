import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

class SampleLoadingPage extends StatelessWidget {
  const SampleLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
