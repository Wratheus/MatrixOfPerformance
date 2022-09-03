import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUI {
  static showCupertinoModalDialog({required BuildContext context, required Widget child}) async {
    return await showCupertinoModalPopup(
        context: context, builder: (context) => child);
  }
  static showMaterialModalDialog({required BuildContext context, required Widget child}) async {
    return await showDialog(
        context: context, builder: (context) => child);
  }
}