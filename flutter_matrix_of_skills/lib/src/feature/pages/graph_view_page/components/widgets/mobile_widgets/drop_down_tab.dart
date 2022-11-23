import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_drop_down_menu.dart';

import '../charts/circular_chart.dart';
import '../charts/col_chart.dart';
import 'drop_down_tab_controller.dart';

// ignore: must_be_immutable
class DropDownChartMenu extends StatefulWidget {
  final List<Map<String, dynamic>> personList;
  final double max;
  List<String> names = [];
  late DropDownController dropDownController;
  late SampleDropDownMenu dropDownMenu;
  DropDownChartMenu({super.key, required this.personList, required this.max}){
    for(int i = 0; i < personList.length; i++){
      names.add(personList[i]['name']);
    }
    dropDownController = DropDownController(selectedPerson: personList[0], selectedValue: names[0], personList: personList);
  }

  @override
  State<DropDownChartMenu> createState() => _DropDownChartMenuState();
}

class _DropDownChartMenuState extends State<DropDownChartMenu> {

  @override
  void initState() {
    widget.dropDownController.addListener(() {setState((){});});
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainCanvas,
      body: Column(
        children: [
          SampleDropDownMenu(values: widget.names, controllerSelectedValue: widget.dropDownController.selectedValue, isExpanded: true, onChanged:  widget.dropDownController.changeSelectedPerson),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.customBlack.withOpacity(0.35),
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: MyColors.mainOuterColor,
                        ),
                        child:
                        Text(widget.dropDownController.selectedValue, style: const TextStyle(
                            color: MyColors.mainBeige,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.customBlack.withOpacity(0.35),
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: MyColors.mainOuterColor,
                        ),
                        child: ColumnChart(data: widget.dropDownController.selectedPerson, maxValue: widget.max)
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.customBlack.withOpacity(0.35),
                                blurRadius: 4,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16),
                            color: MyColors.mainOuterColor,
                          ),
                          child: CircularChart(data: widget.dropDownController.selectedPerson)
                      )
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
