import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/user_data/user_data_cubit.dart';

class TableController extends ChangeNotifier {
  BuildContext? cubitContext;
  String? selectedValue;
  Future<void> update({required String? tableName, required String? selectedValue}) async{
    cubitContext!.read<UserDataCubit>().loadUserData(tableName: tableName, context: cubitContext, selectedValue: selectedValue);
    notifyListeners();
  }
}