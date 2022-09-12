// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/sample_alert_dialog.dart';

class DeleteTableDialog extends StatelessWidget {
  String? tableName;
  DeleteTableDialog({Key? key, required context, required this.tableName}) : super(key: key);

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
            onPressed: () async =>
            {
              await App.supaBaseController?.deleteTable(table: 'user_tables', tableName: tableName!, context: context),
              Navigator.pop(context),
              AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',))
            },
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
