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

  Future<void> loadMainManagementPage({String? tableName, context, String? selectedValue}) async {
    try{
      if (!isClosed) {
        emit(MainManagementPageLoadedState(
            allUserTables: (await App.supaBaseController?.readData(table: "user_tables", context: context)),
            tableData: tableName != null
                ?                                                                                                           // if tableName is not provided,
              (await App.supaBaseController?.readData(table: "user_tables", context: context, tableName: tableName))
                :
              (((await App.supaBaseController?.readData(table: "user_tables", context: context)) as List).isNotEmpty) ?     // try to check if at least 1 table exist
                ((await App.supaBaseController?.readData(table: "user_tables", context: context))[0]['table'])
                  :
                const [],                                                                                                   // and to open it else return []
            values: await App.supaBaseController?.readData(table: "user_tables", context: context),
            tableControllerSelectedValue: selectedValue
        ));
        if (kDebugMode) {
          print("main page is loaded");
        }
      }
    }catch (e) {
      // print(e);
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

