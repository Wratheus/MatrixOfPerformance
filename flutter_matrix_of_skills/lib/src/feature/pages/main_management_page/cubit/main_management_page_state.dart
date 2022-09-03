part of 'main_management_page_cubit.dart';

@immutable
abstract class MainManagementPageState {}

class MainManagementPageInitialState extends MainManagementPageState {}

class MainManagementPageLoadedState extends MainManagementPageState {
  final List<dynamic> tableData;
  final List<dynamic> values;
  MainManagementPageLoadedState({required this.tableData, required this.values});
}

class MainManagementPageErrorState extends MainManagementPageState {
}