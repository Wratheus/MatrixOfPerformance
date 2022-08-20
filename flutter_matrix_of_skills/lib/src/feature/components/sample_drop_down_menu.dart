// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SampleDropDownMenu extends StatefulWidget {
  List<String> values;
  SampleDropDownMenu({Key? key, required this.values}) : super(key: key);
  @override
  State<SampleDropDownMenu> createState() => _SampleDropDownMenuState();
}

class _SampleDropDownMenuState extends State<SampleDropDownMenu> {
  late String? selectedValue = widget.values[0];

  dropDownCallBack(String? dropDownValue) {
    if (dropDownValue is String) {
      setState(() {
        selectedValue = dropDownValue;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        style: whiteTextColor,
        value: selectedValue,
        items: widget.values.map((item) =>
            DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: whiteTextColor)
            )
        ).toList(),
        onChanged: (item) => dropDownCallBack(item),
      );
  }
}
