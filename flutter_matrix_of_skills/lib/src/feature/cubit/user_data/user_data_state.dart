part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitialState extends UserDataState {}

class UserDataLoadedState extends UserDataState {
  final List<Map<String, dynamic>> allUserTables;
  final List<GroupFilterChip> sortingList;
  final List<Map<String, dynamic>> tableData;
  final List<Map<String, dynamic>> values;
  final String? tableControllerSelectedValue;
  UserDataLoadedState({required this.tableData, required this.values, this.tableControllerSelectedValue, required this.allUserTables, required this.sortingList});
}

class UserDataErrorState extends UserDataState {
}