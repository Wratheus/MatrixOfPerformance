// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleBorderContainerCell extends StatelessWidget {
  Widget child;
  Color color;
  double? width;
  double? height;
  SampleBorderContainerCell({Key? key, required this.child, required this.color, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 5,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          border: Border.all(color: MyColors.mainCanvas),
          color: color
      ),
      child: child,
    );
  }
}
