import 'package:flutter/cupertino.dart';

class AppUI {
  static showCupertinoModalDialog({required BuildContext context, required Widget child}) async {
    return await showCupertinoModalPopup(
        context: context, builder: (context) => child);
  }
}