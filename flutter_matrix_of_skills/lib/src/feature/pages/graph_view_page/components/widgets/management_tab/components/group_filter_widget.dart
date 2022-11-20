import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/services/app_ui_disable_glow_effect.dart';
import '../../../../../../components/sample_elevated_button.dart';
import '../../../../../../components/sample_stateful_button/stateful_button.dart';
import '../../../../../../components/sample_stateful_button/stateful_button_controller.dart';
import '../../../../../../components/sample_stateful_button/template.dart';
import '../../../../../main_management_page/components/group_table_view_controller.dart';
import 'group_filter_chip.dart';

// ignore: must_be_immutable
class GroupFilterWidget extends StatefulWidget {


  final TableController tableController;
  final List<Map<String, dynamic>> data;
  late List<Map<String, dynamic>> table;
  final double height;
  final double width;
  List<GroupFilterChip> tableChipList = <GroupFilterChip>[]; // list of all table persons, sorting list is list of selected persons
  ButtonController buttonController = ButtonController();
  GroupFilterWidget({super.key, required this.data, required this.tableController, required this.height, required this.width}){
    if(tableController.sortingList.isEmpty) buttonController.state = ButtonState.disable;
    tableController.selectedValue ??= data[0]['table_name']; // if table is not selected pick first one
    for (Map<String, dynamic> element in data) { // fill name list
      if (element['table_name'] == tableController.selectedValue) {
        table = element['table'].sublist(1);
      }
    }
  }

  @override
  State<GroupFilterWidget> createState() => _GroupFilterWidgetState();
}
class _GroupFilterWidgetState extends State<GroupFilterWidget> {

  // clear selectedList and refill groupList
  fillLists(){
    if(widget.tableChipList.isEmpty) {
      for (int i = 0; i < widget.table.length; i++) {
        widget.tableChipList.add(GroupFilterChip(isSelected: false,
            name: widget.table[i]['name'],
            color: chartColors[i % 21].withOpacity(0.55)
        ));
      }
      if(widget.tableController.sortingList.isNotEmpty){

        for (int i = 0; i < widget.tableController.sortingList.length; i++) {
          for(int k = 0; k < widget.tableChipList.length; k++){
            widget.tableChipList[k].name == widget.tableController.sortingList[i].name ?
                  {
                    widget.tableChipList.removeAt(k),
                  } //remove repeated element
                :
                  () {}; //pass
          }
        }
      }
    }else{
          () => {};
    }
  }

  // loads selected query
  loadFromSelectedList(){
    setState(() {
      List<Map<String, dynamic>> selectedDataObjects = [{'name': null, 'id':null, 'skill1': null, 'skill2': null, 'skill3': null}, ]; // empty {}  to fix headers sublist in future methods of re-rendering page
      for(int i = 0; i < widget.tableController.sortingList.length; i++){
        for(int k = 0; k < widget.table.length; k++){
          if(widget.table[k]['name'] == widget.tableController.sortingList[i].name) selectedDataObjects.add(widget.table[k]);
        }
      }
      if(selectedDataObjects.length >= 3) {
        widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue, tableData: selectedDataObjects, sortingList: widget.tableController.sortingList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fillLists();
    return SizedBox(
      height: widget.height,
      width:  widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: widget.height,
                width: Platform.isWindows ? widget.width/2.1 : widget.width/1.85,
                decoration: BoxDecoration(
                  border:  Border.all(color: MyColors.mainBeige.withOpacity(0.4), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DisableGlowEffect(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.tableChipList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: widget.tableChipList[index],
                        onTap: () { // onClick chip
                          setState(() { // when you select chip
                            (widget.tableChipList[index]).isSelected = true;
                            widget.tableController.sortingList.add(widget.tableChipList[index]);
                            if(widget.tableController.sortingList.isNotEmpty) widget.buttonController.state = ButtonState.enable;
                            for(int i = 0; i < widget.tableController.sortingList.length; i++){
                              widget.tableController.sortingList[i].selectedColor = chartColors[i % 21].withOpacity(0.55);
                            }
                            widget.tableChipList.remove(widget.tableChipList[index]);
                          });
                        }
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: Platform.isWindows ? widget.width/2.1 : widget.width/1.85,
                height: widget.height * 0.8,
                decoration: BoxDecoration(
                  border:  Border.all(color: MyColors.mainBeige.withOpacity(0.4), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DisableGlowEffect(
                  child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: widget.tableController.sortingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          child: widget.tableController.sortingList[index],
                          onTap: () { // onClick chip
                            setState(() { // when you deselect chip
                              (widget.tableController.sortingList[index]).isSelected = false;
                              widget.tableChipList.add(widget.tableController.sortingList[index]);
                              widget.tableController.sortingList.remove(widget.tableController.sortingList[index]);
                              if(widget.tableController.sortingList.isEmpty) widget.buttonController.state = ButtonState.disable; // disable button [Clear] if sortingl ist is empty
                              for(int i = 0; i < widget.tableController.sortingList.length; i++){
                                widget.tableController.sortingList[i].selectedColor = chartColors[i % 21].withOpacity(0.55);
                              }
                            });
                          }
                      );
                    },
                  ),
                ),
              ),
              const Spacer(),
              !Platform.isWindows ? Row(
                children: [
                   SizedBox(
                    width: 80,
                    child: SampleElevatedButton(
                      child: Text("load", style: whiteTextColor),
                      onPressed: () => {
                        widget.tableController.sortingList.isNotEmpty ? loadFromSelectedList()
                        :
                        widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue)
                      },
                    ),
                  ),
                  const SizedBox(width: 5,),
                  SizedBox(
                      width: 80,
                      child: StatefulButton(
                        height: 40,
                        borderRadius: BorderRadius.circular(16.0),
                        color: MyColors.mainInnerColor,
                        border: Border.all(width: 2, color: MyColors.mainBeige.withOpacity(0.4)),
                        onTap: () async {
                          widget.buttonController.state = ButtonState.disable;
                          widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue);
                          widget.buttonController.state = ButtonState.enable;
                        },
                        controller: widget.buttonController,
                        child: const TemplateButton1(
                          title: 'Clear',
                        ),
                      )
                  )
                ],
              ) :
              Row(
                children: [
                  SampleElevatedButton(
                    child: Text("load", style: whiteTextColor),
                    onPressed: () => {
                      widget.tableController.sortingList.isNotEmpty ? loadFromSelectedList()
                          :
                      widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue)
                    },
                  ),
                  const SizedBox(width: 5,),
                  SizedBox(
                      width: 100,
                      child: StatefulButton(
                        height: 44,
                        borderRadius: BorderRadius.circular(14.0),
                        color: MyColors.mainInnerColor,
                        border: Border.all(width: 2, color: MyColors.mainBeige.withOpacity(0.4)),
                        onTap: () async {
                          widget.buttonController.state = ButtonState.disable;
                          widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue);
                          widget.buttonController.state = ButtonState.enable;
                        },
                        controller: widget.buttonController,
                        child: const TemplateButton1(
                          title: 'Clear',
                        ),
                      )
                  )
                ],
              )
            ],
          )
        ]
      ),
    );
  }
}