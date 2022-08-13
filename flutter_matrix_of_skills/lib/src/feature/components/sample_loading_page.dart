import 'package:flutter/material.dart';

class SampleLoadingPage extends StatelessWidget {
  const SampleLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
