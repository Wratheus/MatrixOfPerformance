import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleErrorDialogPage extends StatelessWidget {
  const SampleErrorDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: Center(
        child: Text("Err",
          style: buttonTextColor,
        ),
      ),
    );
  }
}
