import 'package:flutter/cupertino.dart';

class DropDownController extends ChangeNotifier{
  String selectedValue;
  final List<Map<String, dynamic>>personList;
  late Map<String, dynamic> selectedPerson;
  DropDownController({required this.selectedValue, required this.personList, required this.selectedPerson});

  changeSelectedPerson(String? dropDownValue) {
    if (dropDownValue is String) {
      selectedValue = dropDownValue;
      for (int i = 0; i < personList.length; i++) {
        if (personList[i]['name'] == selectedValue) {
          selectedPerson = personList[i];
          notifyListeners();
          break;
        }
      }
    }
  }
}