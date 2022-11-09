import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/management_tab/components/group_filter_chip.dart';
import '../../../cubit/user_data/user_data_cubit.dart';

class TableController extends ChangeNotifier {
  BuildContext? cubitContext;
  String? selectedValue;
  List<GroupFilterChip> sortingList = [];
  Future<void> update({required String? tableName, required String? selectedValue, List<GroupFilterChip>? sortingList, List<Map<String, dynamic>>? tableData}) async{
    cubitContext!.read<UserDataCubit>().loadUserData(tableName: tableName, context: cubitContext, selectedValue: selectedValue, sortingList: sortingList, tableData: tableData);
    notifyListeners();
  }
}