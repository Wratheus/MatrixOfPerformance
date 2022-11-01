import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/user_data/user_data_cubit.dart';

class TableController extends ChangeNotifier {
  BuildContext? cubitContext;
  String? selectedValue;
  List<String> sortingList = [];
  Future<void> update({required String? tableName, required String? selectedValue, List<String>? sortingList, List<Map<String, dynamic>>? tableData}) async{
    cubitContext!.read<UserDataCubit>().loadUserData(tableName: tableName, context: cubitContext, selectedValue: selectedValue, sortingList: sortingList, tableData: tableData);
    notifyListeners();
  }
}