import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/new_table_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/app_ui_modals.dart';
import '../../../cubit/user_data/user_data_cubit.dart';

class EmptyTablesDialog extends StatelessWidget {
  const EmptyTablesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TableController tableController = TableController();
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      tableController.cubitContext = context;
      // share cubit context to tableController to have ability to update
      tableController.selectedValue = (state as UserDataLoadedState).tableControllerSelectedValue;
      // share selected value if it was saved to state with controller
      return Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body:  AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          actions: [
            TextButton(
              child: Text("OK", style: whiteTextColor),
              onPressed: () => {
                AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: state.allUserTables, tableController: tableController))
              },
            )
          ],
          title: Text("Hello 👋", style: whiteTextColor, textAlign: TextAlign.center),
          content: Text("Welcome to Matrix of Performance app\nTo start using it create new table", style: whiteTextColor, textAlign: TextAlign.center,),
        )
      );
    }
    );
  }
}
