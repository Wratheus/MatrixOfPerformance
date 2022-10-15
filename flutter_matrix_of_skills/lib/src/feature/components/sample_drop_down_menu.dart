// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleDropDownMenu extends StatefulWidget {
  List<String> values;
  late String selectedValue;
  SampleDropDownMenu({super.key, required this.values}) { selectedValue = values[0];}
  @override
  State<SampleDropDownMenu> createState() => _SampleDropDownMenuState();
}

class _SampleDropDownMenuState extends State<SampleDropDownMenu> {

  dropDownCallBack(String? dropDownValue) {
    if (dropDownValue is String) {
      setState(() {
        widget.selectedValue = dropDownValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        style: whiteTextColor,
        dropdownColor: MyColors.mainInnerColor,
        value: widget.selectedValue,
        items: widget.values.map((item) =>
            DropdownMenuItem<String>(
                value: item,
                child: Row(
                  children: [
                    Text(item, style: whiteTextColor),
                  ],
                )
            )
        ).toList(),
        onChanged: (item) => dropDownCallBack(item),
      );
  }
}
