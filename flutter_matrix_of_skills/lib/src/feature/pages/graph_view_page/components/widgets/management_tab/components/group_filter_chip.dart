// ignore: implementation_imports
import 'package:flutter/material.dart';

import '../../../../../../../core/constants/constants.dart';

class GroupFilterChip extends StatelessWidget {
  bool isSelected; 
  final String name;
  final Color color;
  GroupFilterChip({super.key, required this.isSelected, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    Widget selectArrowIcon = CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white.withOpacity(0.8),
                              child: InkWell(onTap: (() => isSelected = true), child: Icon(Icons.arrow_forward_ios_rounded, color: color, size: 12)));
    Widget reverseArrowIcon = CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white.withOpacity(0.8),
                                child: InkWell(onTap: (() => isSelected = false), child: Icon(Icons.arrow_back_ios_new_rounded, color: color, size: 12)));

    return IntrinsicHeight(
      child: Container(
        width: 200,
        decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                !isSelected ? selectArrowIcon : const SizedBox(),
                HeadLetter(color: color, name: name),
                const SizedBox(width: 10),
                Text(name, style: whiteTextColor),
              ],
            ),
            isSelected ? reverseArrowIcon : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class HeadLetter extends StatelessWidget {
  final String name;
  final Color color;
  const HeadLetter({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: Text(name[0].toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),),
                  );
  }
}
