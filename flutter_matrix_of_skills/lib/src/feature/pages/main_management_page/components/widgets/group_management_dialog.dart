// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';

class GroupManagementDialog extends StatelessWidget {
  bool? newTable;
  bool? newRow;
  bool? newColumn;
  GroupManagementDialog({Key? key, required context, this.newRow, this.newTable, this.newColumn}) : super(key: key);
  // TODO: create for loop textfields for sql
  @override
  Widget build(BuildContext context) {
    if (newTable == true) {
      TextEditingController newTableTextController = TextEditingController();
      return AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          title: Text("🧵 Create new table", style: whiteTextColor),
          content: SizedBox(
            height: 80,
            child: Column(
              children: [
                Text("Enter the name", style: whiteTextColor),
                const SizedBox(height: 5),
                SampleTextField(textController: newTableTextController, labelText: "Table name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor)
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text("OK", style: whiteTextColor),
              onPressed: () async => {
                await App.supaBaseController?.insertNewTable(newTableName: newTableTextController.text, context: context),
                Navigator.pop(context)
              },
            ),
            CupertinoDialogAction(
              child: Text("Cancel", style: whiteTextColor),
              onPressed: () => {
                Navigator.pop(context)
              },
            )
          ]
      );
    }
    if(newColumn == true){
      return Container();
    }
    if(newRow == true){
      return Container();
    }
    else {
      return Container();
    }
  }
}
