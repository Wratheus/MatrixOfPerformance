import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../components/sample_drop_down_menu.dart';
import '../../../../../components/sample_elevated_button.dart';

// ignore: must_be_immutable
class ComparisonManagement extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  late List<Map<String, dynamic>> table;
  final TableController tableController;
  List<String> dataNameList = [];
  List<String> selectedList = [];
  String selectedValueDropDown = '';
  ComparisonManagement({super.key, required this.data, required this.tableController}) {
    tableController.selectedValue ??= data[0]['table_name'];
    for (Map<String, dynamic> element in data) {
      if(element['table_name'] == tableController.selectedValue){
        table = element['table'].sublist(1);
        for(int i = 0; i <  table.length; i++){dataNameList.add(table[i]['name']);}
      }
    }

  }
  @override
  State<ComparisonManagement> createState() => _ComparisonManagementState();
}

class _ComparisonManagementState extends State<ComparisonManagement> {

  addToSelectedList({required String selectedValue}){
    setState(() {
      widget.tableController.sortingList.contains(selectedValue) ? false : widget.tableController.sortingList.add(selectedValue);
      widget.selectedValueDropDown = selectedValue;
    });
  }
  removeFromSelectedList({required String selectedValue}){
    setState(() {
      widget.tableController.sortingList.contains(selectedValue) ? widget.tableController.sortingList.remove(selectedValue) : false;
      widget.selectedValueDropDown = selectedValue;
    });
  }
  loadFromSelectedList({required List<Map<String, dynamic>> data}){
    setState(() {
      List<Map<String, dynamic>> selectedDataObjects = [{'name': null, 'id':null, 'skill1': null, 'skill2': null, 'skill3': null,}]; // 0 to fix headers sublisting in future methods of re-rendering page
      for(int i = 0; i < widget.tableController.sortingList.length; i++){
        for(int k = 0; k < data.length; k++){
          if(data[k]['name'] == widget.tableController.sortingList[i]) selectedDataObjects.add(data[k]);
        }
      }
      if(selectedDataObjects.isNotEmpty && selectedDataObjects.length >= 2) {
        widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue, tableData: selectedDataObjects, sortingList: widget.tableController.sortingList);
      }
    });
  }

    @override
  Widget build(BuildContext context) {
    SampleDropDownMenu nameDropDown = SampleDropDownMenu(values: widget.dataNameList, isExpanded: false);
    if(widget.selectedValueDropDown.isNotEmpty) nameDropDown.selectedValue = widget.selectedValueDropDown;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Selected persons: ", style: whiteTextColor),
            ],
          ),
          Row(
            children: [
              nameDropDown,
              const SizedBox(width: 5,),
              SampleElevatedButton(onPressed: () => {
                addToSelectedList(selectedValue: nameDropDown.selectedValue)},
                  child: Text("add", style: whiteTextColor),
              ),
              const SizedBox(width: 5,),
              SampleElevatedButton(onPressed: () => {
                removeFromSelectedList(selectedValue: nameDropDown.selectedValue)},
                child: Text("remove", style: whiteTextColor),
              ),
              const SizedBox(width: 5,),
              SampleElevatedButton(onPressed: () => {
                loadFromSelectedList(data: widget.table)},
                child: Text("load", style: whiteTextColor),
              ),
              const SizedBox(width: 5,),
              SampleElevatedButton(
                child: Text('Clear', style: whiteTextColor),
                onPressed: () => {
                  widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue)
                },
              )
            ],
          ),
          (widget.tableController.sortingList.isNotEmpty)
              ?
          Row(children: [
            for(int i = 0; i < widget.tableController.sortingList.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Chip(
                  label: Text(widget.tableController.sortingList[i], style: whiteTextColor),
                  backgroundColor: chartColors.elementAt(i % 10),
                  avatar: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: Text(widget.tableController.sortingList[i][0].toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: chartColors.elementAt(i % 10)),),
                  ),
                ),
              )
          ])
              :
          Container()
        ],
      ),
    );
  }
}