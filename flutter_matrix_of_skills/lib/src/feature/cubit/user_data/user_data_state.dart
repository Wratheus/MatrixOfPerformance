part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitialState extends UserDataState {}

class UserDataLoadedState extends UserDataState {
  final List<dynamic> allUserTables;
  final List<dynamic> tableData;
  final List<dynamic> values;
  final String? tableControllerSelectedValue;
  UserDataLoadedState({required this.tableData, required this.values, this.tableControllerSelectedValue, required this.allUserTables});
}

class UserDataErrorState extends UserDataState {
}