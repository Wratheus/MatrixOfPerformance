// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/sample_text_field.dart';

class NewTableFillDialog extends StatelessWidget {
  void fillNewTableAction({required context, required List<TextEditingController> textControllers, required String tableName}) async {
    Map<String, dynamic> columnNames = {};
    for(int i = 0; i < textControllers.length; i++) {
      if(textControllers[i].text.isNotEmpty) {
        columnNames[textControllers[i].text] = null;
      }
    }
    await App.supaBaseController?.insertNewTable(table: 'user_tables', tableName: tableName, columns: columnNames, context: context);
    Navigator.pop(context);
    AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success'));
  }

  // Init
  String tableName;
  int newTableColumnsAmount;
  NewTableFillDialog({Key? key, required context, required this.newTableColumnsAmount, required this.tableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textControllers = [];
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Please, fill headers 🥺👍", style: whiteTextColor),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newTableColumnsAmount,
                    itemBuilder: (BuildContext context, int index) {
                      textControllers.add(TextEditingController());
                      return Column(
                        children: [
                          const SizedBox(height: 5),
                          SampleTextField(labelText: 'Column ${index+1}:', textColor: whiteTextColor, hideText: false, textController: textControllers[index], borderColor: MyColors.mainBeige, width: 250),
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("OK", style: whiteTextColor),
            onPressed: () {fillNewTableAction(context: context, textControllers: textControllers, tableName: tableName);},
          ),
          TextButton(
            child: Text("Cancel", style: whiteTextColor),
            onPressed: () => {
              Navigator.pop(context)
            },
          )
        ]
    );
  }
}
