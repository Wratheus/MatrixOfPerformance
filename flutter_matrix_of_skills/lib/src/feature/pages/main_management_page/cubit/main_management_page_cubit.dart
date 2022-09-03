import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/classes/app.dart';

part 'main_management_page_state.dart';

class MainManagementPageCubit extends Cubit<MainManagementPageState> {
  MainManagementPageCubit() : super(MainManagementPageInitialState());

  Future<void> informInitial() async {
    if (!isClosed) {
      if (kDebugMode) {
        print("main page is loading");
      }
    }
  }

  Future<void> loadMainManagementPage({tableName, context}) async {
    try{
      if (!isClosed) {
        emit(MainManagementPageLoadedState(
            tableData: const [],
            values: await App.supaBaseController?.readData(table: "user_tables", context: context, tableName: tableName)
        ));
        if (kDebugMode) {
          print("main page is loaded");
        }
      }
    }catch (e) {
      print(e);
      if (!isClosed) {
        emit(MainManagementPageErrorState());
      }
    }
  }

    Future<void> reloadMainManagementPage() async {
      if (!isClosed){
        emit(MainManagementPageInitialState());
      }
    }
  }

