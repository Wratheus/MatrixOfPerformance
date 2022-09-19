// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';

// Group Management Dialog Builder
class NewRowDialog extends StatelessWidget {

  final TableController tableController;
  List<dynamic> tableValues;
  String? tableName;


  void newRowAction({required List<TextEditingController> textControllers, required Map<String, dynamic> newRow, required context}) async {
    newRow[(tableValues.last as Map).keys.elementAt(0)] = (tableValues.last as Map).values.elementAt(0) + 1; // increment id and save as string
    for(int i = 0; i < textControllers.length; i++) {
      if(textControllers[i].text.isNotEmpty) {
        newRow[(tableValues[0] as Map).keys.elementAt(i+1)] = textControllers[i].text;
      } else{
        newRow[(tableValues[0] as Map).keys.elementAt(i+1)] = null;
      }
    }
    tableValues.add(newRow);
    await App.supaBaseController?.updateTable(table: 'user_tables',
        tableName: tableName,
        columns: tableValues,
        context: context
    );
    await tableController.update(tableName: tableName, selectedValue: tableController.selectedValue);
  }
  NewRowDialog(
      {Key? key, required context, required this.tableValues, required this.tableName, required this.tableController})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newRow = {};
    List<TextEditingController> textControllers = [];
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Please, fill new row", style: whiteTextColor),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tableValues[0].length,
                    itemBuilder: (BuildContext context, index) {
                      if(index == 0) {
                        return const SizedBox();
                      }else{
                        textControllers.add(TextEditingController());
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            SampleTextField(
                                labelText: '${(tableValues[0] as Map).keys.elementAt(index)} value:',
                                textColor: whiteTextColor,
                                hideText: false,
                                textController: textControllers[index-1],
                                borderColor: MyColors.mainBeige,
                                width: 250),
                          ],
                        );
                      }
                    }
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {newRowAction(textControllers: textControllers, newRow: newRow, context: context);},
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