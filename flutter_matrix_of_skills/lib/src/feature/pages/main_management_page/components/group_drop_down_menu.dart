// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../cubit/user_data/user_data_cubit.dart';

class GroupDropDownMenu extends StatefulWidget {

  final TableController tableController;
  List<Map<String, dynamic>> values = [];
  bool isExpanded;

  GroupDropDownMenu({Key? key, required this.tableController, required this.isExpanded}) : super(key: key);
  @override
  State<GroupDropDownMenu> createState() => _GroupDropDownMenuState();
}

class _GroupDropDownMenuState extends State<GroupDropDownMenu> {
  List<Map>? selectedTableData;
  dropDownCallBack(String? dropDownValue) {
    if (dropDownValue is String) {
      setState(() {
        widget.tableController.selectedValue = dropDownValue;
        widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if ((state as UserDataLoadedState).values.isEmpty == false) {
          widget.values = state.values;
          widget.tableController.selectedValue ??= state.values[0]['table_name'];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: MyColors.mainOuterColor,
                  border: Border.all(color: MyColors.mainBeige, width:2), //border of dropdown button
                  borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:10, right:10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(8.0),
                    icon: const Icon(Icons.keyboard_arrow_down_outlined, color: MyColors.mainBeige),
                    style: whiteTextColor,
                    focusColor: MyColors.mainOuterColor,
                    iconDisabledColor: MyColors.mainOuterColor,
                    iconEnabledColor: MyColors.mainOuterColor,
                    dropdownColor: MyColors.mainOuterColor,
                    value: widget.tableController.selectedValue,
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
                  ),
                ),
              ),
            ),
          );
        }
        else {
          return const SizedBox(height: 20);
        }
      }
    );
  }
}
