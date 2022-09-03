import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../cubit/main_management_page_cubit.dart';

class GroupManagementDropDownMenu extends StatefulWidget {
  const GroupManagementDropDownMenu({Key? key}) : super(key: key);
  @override
  State<GroupManagementDropDownMenu> createState() => _SampleDropDownMenuState();
}

class _SampleDropDownMenuState extends State<GroupManagementDropDownMenu> {
  String? selectedValue;

  dropDownCallBack(String? dropDownValue) {
    if (dropDownValue is String) {
      setState(() {
        selectedValue = dropDownValue;
        context.read<MainManagementPageCubit>().loadMainManagementPage(
            tableName: selectedValue, context: context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(
      builder: (context, state) {
        if ((state as MainManagementPageLoadedState).values.isEmpty == false) {
          return DropdownButton<String>(
            style: whiteTextColor,
            dropdownColor: MyColors.mainInnerColor,
            value: selectedValue,
            items: state.values.map((item) =>
                DropdownMenuItem<String>(
                    value: item['table_name'],
                    child: Row(
                      children: [
                        Text(item['table_name'], style: whiteTextColor),
                      ],
                    )
                )
            ).toList(),
            onChanged: (item) => dropDownCallBack(item),
          );
        }
        else {
          return const SizedBox(height: 20);
        }
      }
    );
  }
}
