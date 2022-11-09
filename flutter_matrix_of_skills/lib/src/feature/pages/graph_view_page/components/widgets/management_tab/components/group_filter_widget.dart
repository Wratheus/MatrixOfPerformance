import 'package:flutter/material.dart';
import '../../../../../../../core/constants/constants.dart';
import '../../../../../../components/sample_elevated_button.dart';
import '../../../../../main_management_page/components/group_table_view_controller.dart';
import 'group_filter_chip.dart';

// ignore: must_be_immutable
class GroupFilterWidget extends StatefulWidget {


  final TableController tableController;
  final List<Map<String, dynamic>> data;
  late List<Map<String, dynamic>> table;
  final double height;
  List<GroupFilterChip> tableChipList = <GroupFilterChip>[]; // list of all table persons, sorting list is list of selected persons

  GroupFilterWidget({super.key, required this.data, required this.tableController, required this.height}){
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
      List<Map<String, dynamic>> selectedDataObjects = [{'name': null, 'id':null, 'skill1': null, 'skill2': null, 'skill3': null}, ]; // empty {}  to fix headers sublisting in future methods of re-rendering page
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
      width:  520,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: widget.height,
                width: 250,
                decoration: BoxDecoration(
                  border:  Border.all(color: MyColors.mainBeige.withOpacity(0.4), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
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
                          widget.tableChipList.remove(widget.tableChipList[index]);
                        });
                      }
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 250,
                height: widget.height * 0.8,
                decoration: BoxDecoration(
                  border:  Border.all(color: MyColors.mainBeige.withOpacity(0.4), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
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
                          });
                        }
                    );
                  },
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  SampleElevatedButton(
                    child: Text("load", style: whiteTextColor),
                    onPressed: () => {
                      loadFromSelectedList()},
                  ),
                  const SizedBox(width: 5,),
                  SampleElevatedButton(
                    child: Text('Clear', style: whiteTextColor),
                    onPressed: () => {
                      widget.tableController.update(tableName: widget.tableController.selectedValue, selectedValue: widget.tableController.selectedValue)
                    },
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