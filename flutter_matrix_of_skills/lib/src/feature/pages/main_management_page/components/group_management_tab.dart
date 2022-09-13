import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/widgets/delete_table_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/widgets/group_management_drop_down_menu.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/widgets/new_table_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/responsive_layout.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/app_ui_modals.dart';
import '../cubit/main_management_page_cubit.dart';
import 'widgets/new_row_dialog.dart';

class GroupManagementTab extends StatelessWidget {
  const GroupManagementTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GroupManagementDropDownMenu managementTabDropDownMenu = GroupManagementDropDownMenu();

    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(builder: (context, state) {
      return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
      // Desktop Layout
      Row(
        children: [
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Select table: ",
                        style: whiteTextColor
                    ),
                    const SizedBox(width: 30),
                    managementTabDropDownMenu,
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: ()=>{
                        AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state as MainManagementPageLoadedState).values)),
                        },
                        child: Text("New", style: whiteTextColor)),
                    const SizedBox(width: 5),
                    ElevatedButton(
                        onPressed: ()=>{
                          AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: managementTabDropDownMenu.selectedValue, context: context)),
                        },
                        child: Text("Delete", style: whiteTextColor)),
                    // TODO: Copy from another table method later
                    const SizedBox(width: 5),
                    ElevatedButton(
                        onPressed: ()=>{
                        },
                        child: Text("Copy", style: whiteTextColor)),
                  ],
                )
              ],
            ),
          ),
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: managementTabDropDownMenu.selectedValue, context: context, tableValues: (state as MainManagementPageLoadedState).tableData)),
                    },
                    child: Text("Add row", style: whiteTextColor)
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Add column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Edit row", style: whiteTextColor)
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Edit column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Delete row", style: whiteTextColor)
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Delete column", style: whiteTextColor)
                ),
              ],
            ),
          ),

        ],
      ) :
      // Mobile Layout
      Column(
        children: [
          SampleStyleContainer(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select table",
                      style: whiteTextColor
                  ),
                  Row(
                    children: [
                      managementTabDropDownMenu,
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: ()=>{
                            AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state as MainManagementPageLoadedState).values)),
                          },
                          child: Text("New", style: whiteTextColor)),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: ()=>{
                            AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: managementTabDropDownMenu.selectedValue, context: context)),
                          },
                          child: Text("Delete", style: whiteTextColor)),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: ()=>{
                          },
                          child: Text("Copy", style: whiteTextColor)),
                    ],
                  ),
                ]),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()=>{
                      AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: managementTabDropDownMenu.selectedValue, context: context, tableValues: (state as MainManagementPageLoadedState).tableData)),
                    },
                    child: Text("Add row", style: whiteTextColor)
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Add column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Edit row", style: whiteTextColor)
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Edit column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Delete row", style: whiteTextColor)
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: ()=>{},
                    child: Text("Delete column", style: whiteTextColor)
                ),
              ],
            ),
          ),

        ],
      );
    });
  }
}
