import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/main_management_page_cubit.dart';

class TableController extends ChangeNotifier {
  BuildContext? cubitContext;
  String? selectedValue;
  Future<void> update({required String? tableName}) async{
    cubitContext!.read<MainManagementPageCubit>().loadMainManagementPage(tableName: tableName, context: cubitContext);
    notifyListeners();
  }
}