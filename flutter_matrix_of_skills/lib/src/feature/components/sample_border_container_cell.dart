import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
class SampleBorderContainerCell extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? width;
  final double? height;
  const SampleBorderContainerCell({Key? key, required this.child, required this.color, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 5,
      height: height,
      decoration: Platform.isWindows ?
      BoxDecoration(
          borderRadius: BorderRadius.circular(0.1),
          border: Border.all(color: MyColors.mainCanvas),
          color: color
      ) :
      BoxDecoration(
          borderRadius: BorderRadius.circular(0.1),
          border: Border.all(color: MyColors.mainCanvas),
          color: color
      ),
      child: child,
    );
  }
}
