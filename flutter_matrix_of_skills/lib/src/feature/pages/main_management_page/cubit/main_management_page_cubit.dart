import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/classes/app.dart';

part 'main_management_page_state.dart';

class MainManagementPageCubit extends Cubit<MainManagementPageState> {
  MainManagementPageCubit() : super(MainManagementPageInitialState());

  Future<void> informInitial() async {
    if (kDebugMode) {
      print("main page is loading");
    }
  }

  Future<void> loadMainManagementPage({tableName}) async {
    await Future.delayed(const Duration(milliseconds: 100)); // while no server request this is too fast and causes bug )
    try{
      if (!isClosed) {
        if(tableName != null) {
          emit(MainManagementPageLoadedState(
              tableData: await App.supaBaseController?.readData(table: tableName)
          ));
        } else {
          emit(MainManagementPageLoadedState(
              tableData: const []
          ));
        }
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

