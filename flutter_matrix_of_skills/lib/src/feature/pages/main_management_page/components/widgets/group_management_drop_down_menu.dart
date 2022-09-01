// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../cubit/main_management_page_cubit.dart';

class GroupManagementDropDownMenu extends StatefulWidget {
  List<String> values;
  GroupManagementDropDownMenu({Key? key, required this.values}) : super(key: key);
  @override
  State<GroupManagementDropDownMenu> createState() => _SampleDropDownMenuState();
}

class _SampleDropDownMenuState extends State<GroupManagementDropDownMenu> {
  late String? selectedValue = widget.values[0];

  dropDownCallBack(String? dropDownValue) {
    if (dropDownValue is String) {
      setState(() {
        selectedValue = dropDownValue;
        context.read<MainManagementPageCubit>().loadMainManagementPage(tableName: selectedValue);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        style: whiteTextColor,
        dropdownColor: MyColors.mainInnerColor,
        value: selectedValue,
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
