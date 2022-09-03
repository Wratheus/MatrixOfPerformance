import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/widgets/group_management_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/widgets/group_management_drop_down_menu.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/responsive_layout.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/app_ui_modals.dart';

class GroupManagementTab extends StatelessWidget {
  const GroupManagementTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
        // Desktop Layout
    Row(
      children: [
        SampleStyleContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select table",
                  style: whiteTextColor
              ),
              const GroupManagementDropDownMenu(),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: ()=>{
                  AppUI.showMaterialModalDialog(context: context, child: GroupManagementDialog(newTable: true, context: context)),
                  },
                  child: Text("New", style: whiteTextColor))
            ],
          ),
        ),
        SampleStyleContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: ()=>{},
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
                    const GroupManagementDropDownMenu(),
                    ElevatedButton(
                        onPressed: ()=>{
                          AppUI.showMaterialModalDialog(context: context, child: GroupManagementDialog(newTable: true, context: context)),
                        },
                        child: Text("New", style: whiteTextColor))
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
                  onPressed: ()=>{},
                  child: Text("Add row", style: whiteTextColor)
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Add row", style: whiteTextColor)
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
  }
}
