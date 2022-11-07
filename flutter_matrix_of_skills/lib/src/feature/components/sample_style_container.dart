import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleStyleContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  const SampleStyleContainer({Key? key, required this.child, this.height, this.width, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors.customBlack.withOpacity(0.35),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: color?? MyColors.mainOuterColor,
        ),
        child: child,
    );
  }
}
