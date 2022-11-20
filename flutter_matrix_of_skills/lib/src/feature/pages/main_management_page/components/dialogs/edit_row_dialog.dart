// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/edit_row_fill_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/sample_drop_down_menu.dart';

// Group Management Dialog Builder
class EditRowDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;

  Future<bool> editRowAction({required String name, required context, required List<Map<String, dynamic>> tableValues, required String tableName}) async {
  Map<String, dynamic> match;
    for (Map<String, dynamic> element in tableValues) {
      if(element['id'] == int.parse(name.substring(0, name.indexOf(' ')))) {
        match = element;
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: EditRowFillDialog(context: context, tableValues: tableValues, tableName: tableName, tableController: tableController, match: match));
        return true;
      }
    }
    return false;
  }

  EditRowDialog({Key? key, required context, required this.tableValues, required this.tableName, required this.tableController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> names = [];
    for(int i = 1; i < tableValues.length; i++){ // i=1 skip sublist
      names.add('${tableValues[i]['id']} ${tableValues[i]['name']}');
    }
    SampleDropDownMenu dropDownMenu = SampleDropDownMenu(values: names, isExpanded: true);
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Edit row 🧵", style: whiteTextColor, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: dropDownMenu),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {editRowAction(context: context, tableValues: tableValues, tableName: tableName!, name: dropDownMenu.selectedValue);},
              child: Text("OK", style: whiteTextColor)
          ),
          TextButton(
            child: Text("Cancel", style: whiteTextColor),
            onPressed: () =>
            {
              Navigator.pop(context)
            },
          )
        ]
    );
  }
}