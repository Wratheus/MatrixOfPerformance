// ignore: implementation_imports
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../../core/constants/constants.dart';

// ignore: must_be_immutable
class GroupFilterChip extends StatelessWidget {
  bool isSelected; 
  final String name;
  Color selectedColor = Colors.greenAccent;
  final Color color;
  GroupFilterChip({super.key, required this.isSelected, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    Widget selectArrowIcon = CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white.withOpacity(0.25),
                              child: const Icon(Icons.arrow_forward_ios_rounded, color: MyColors.customBlack, size: 12));
    Widget reverseArrowIcon = CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white.withOpacity(0.25),
                                child: const Icon(Icons.arrow_back_ios_new_rounded, color: MyColors.customBlack, size: 12));

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: IntrinsicHeight(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
                color: isSelected ? selectedColor : color,
                borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  isSelected ?  Row(children: [reverseArrowIcon, const SizedBox(width: 5)],) : const SizedBox(),
                  HeadLetter(color: color, name: name),
                  const SizedBox(width: 10),
                  Platform.isWindows ? Text(name.length > 20? '${name.substring(0, 10)}.' : name, style: whiteTextColor) :
                  Text(name.length > 10? '${name.substring(0, 10)}.' : name, style: whiteTextColor),
                ],
              ),
              !isSelected ? selectArrowIcon : const SizedBox(),
            ],
          ),
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
                    backgroundColor: Colors.white.withOpacity(0.25),
                    child: Text(name[0].toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: MyColors.customBlack),),
                  );
  }
}
