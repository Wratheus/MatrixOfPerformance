import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../core/classes/app.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitialState());

  Future<void> informInitial() async {
    if (!isClosed) {
      if (kDebugMode) {
        print("User data is loading");
      }
    }
  }

  Future<void> loadUserData({String? tableName, context, String? selectedValue}) async {
    try{
      if (!isClosed) {
        emit(UserDataLoadedState(
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
          print("User data is loaded");
        }
      }
    }catch (e) {
      // print(e);
      if (!isClosed) {
        emit(UserDataErrorState());
      }
    }
  }
  Future<void> reloadUserData() async {
    if (!isClosed){
      emit(UserDataInitialState());
    }
  }
  }
