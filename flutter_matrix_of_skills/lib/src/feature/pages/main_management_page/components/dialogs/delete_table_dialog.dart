// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';

class DeleteTableDialog extends StatelessWidget {

  final TableController tableController;
  String tableName;


  void deleteTableAction({required context, required String tableName}) async{
      await App.supaBaseController.deleteTable(table: 'user_tables', tableName: tableName, context: context);
      await tableController.update(tableName: null, selectedValue: null);
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',));
  }

  // Init
  DeleteTableDialog({Key? key, required context, required this.tableName, required this.tableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text('Delete table "$tableName"? 🥺', style: whiteTextColor),

        content: SizedBox(
          height: 50,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text("Are you sure you want to delete $tableName", style: whiteTextColor)),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("OK", style: whiteTextColor),
            onPressed: () {deleteTableAction(context: context, tableName: tableName);}
          ),
          const SizedBox(height: 10),
          TextButton(
            child: Text("Cancel", style: whiteTextColor),
            onPressed: () =>
            {
              Navigator.pop(context),
            },
          )
        ]
    );
  }
}
