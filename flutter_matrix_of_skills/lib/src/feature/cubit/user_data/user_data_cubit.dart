import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../core/classes/app.dart';
import '../../pages/graph_view_page/components/widgets/management_tab/components/group_filter_chip.dart';

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

  Future<void> loadUserData({String? tableName, context, String? selectedValue, List<Map<String, dynamic>>? tableData, List<GroupFilterChip>? sortingList}) async {
    try{
      if (!isClosed) {
        emit(UserDataLoadedState(
            sortingList: sortingList ?? [],
            allUserTables: (await App.supaBaseController.readData(postGreTable: "user_tables", context: context)),
            tableData: (tableData != null && tableData.isNotEmpty) ? tableData : (tableName != null // if tableData was not provided (most cases)
                ?                                                                                                           // if tableName is not provided,
              (await App.supaBaseController.readData(postGreTable: "user_tables", context: context, tableName: tableName))
                :
              (((await App.supaBaseController.readData(postGreTable: "user_tables", context: context)).isNotEmpty) ?     // try to check if at least 1 table exist
                ((await App.supaBaseController.readData(postGreTable: "user_tables", context: context))[0]['table'])
                  :
                const [])),                                                                                                   // and to open it else return []
              values: await App.supaBaseController.readData(postGreTable: "user_tables", context: context),
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

