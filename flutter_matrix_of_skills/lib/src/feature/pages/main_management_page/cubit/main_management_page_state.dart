part of 'main_management_page_cubit.dart';

@immutable
abstract class MainManagementPageState {}

class MainManagementPageInitialState extends MainManagementPageState {}

class MainManagementPageLoadedState extends MainManagementPageState {
  final List<dynamic> allUserTables;
  final List<dynamic> tableData;
  final List<dynamic> values;
  final String? tableControllerSelectedValue; // TODO: check final properly
  MainManagementPageLoadedState({required this.tableData, required this.values, this.tableControllerSelectedValue, required this.allUserTables});
}

class MainManagementPageErrorState extends MainManagementPageState {
}