part of 'main_management_page_cubit.dart';

@immutable
abstract class MainManagementPageState {}

class MainManagementPageInitialState extends MainManagementPageState {}

class MainManagementPageLoadedState extends MainManagementPageState {
  final List<dynamic> tableData;

  MainManagementPageLoadedState({required this.tableData});
}

class MainManagementPageErrorState extends MainManagementPageState {
}