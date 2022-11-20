// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/sample_drop_down_menu.dart';

// Group Management Dialog Builder
class DeleteRowDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;
  int? id;


  Future<bool> deleteRowAction({required String name, required context, required List<Map<String, dynamic>> tableValues}) async {
    Map<String, dynamic> match;
    for (Map<String, dynamic> element in tableValues) {
      if(element['id'] == int.parse(name.substring(0, name.indexOf(' ')))) {
        match = element;
        tableValues.removeWhere((element) => element == match); // delete match id
        await App.supaBaseController.updateTable(table: 'user_tables', // update table if match was found
            tableName: tableName,
            columns: tableValues,
            context: context
        );
        await tableController.update(tableName: tableName, selectedValue: tableController.selectedValue);
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success'));
        return true;
      }
    }
    return false;
  }


  DeleteRowDialog(
      {Key? key, required context, required this.tableValues, required this.tableName, required this.tableController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> names = [];
    for(int i = 1; i < tableValues.length; i++){ // i=1 skip sublist
      names.add('${tableValues[i]['id']} ${tableValues[i]['name']}');
    }
    SampleDropDownMenu dropDownMenu = SampleDropDownMenu(values: names, isExpanded: true);

    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Delete row 🧵", style: whiteTextColor, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: dropDownMenu),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {deleteRowAction(name: dropDownMenu.selectedValue, context: context, tableValues: tableValues);},
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