import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/secure_storage_controller.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_error_dialog.dart';

import 'client_credentials/auth.dart';
import '../classes/app.dart';
import '../services/app_ui_modals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class SupaBaseController {
  final SupabaseClient client = SupabaseClient(ClientCredentials().url, ClientCredentials().key);


  Future<bool> singUp({required String email, required String password, required context})async{
    final response = await client.auth.signUp(email, password);
    final error = response.error;
    if(error != null){
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false;
    }
    if(response.user != null) {
      return true;
    }
    return false;
  }

  Future<bool> signIn({required String email, required String password, required context}) async {
    final response = await client.auth.signIn(
        email: email, password: password);
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false;
    }
    String newSession = (json.encode(App.supaBaseController?.client.auth.session()));
    await SecureStorage.setSessionToStorage(newSession);
    return true;
  }
  // try to recreate session with refresh token
  Future<bool> sessionSignIn() async {
    String? lastSession = await SecureStorage.getSessionFromStorage();
    if (lastSession != null) {
      Map<dynamic, dynamic> jsonSession = jsonDecode(lastSession);
      await App.supaBaseController?.client.auth.setSession(jsonSession['refresh_token']);
      if (App.supaBaseController?.client.auth.session() != null) {
        String newSession = (json.encode(App.supaBaseController?.client.auth.session()));
        await SecureStorage.setSessionToStorage(newSession);
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> signOut({required context})async{
    final response = await client.auth.signOut();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if(client.auth.currentUser == null) {
      await SecureStorage.deleteAllData();
      return true;
    } else {
      return false;
    }
  }

  insertNewTable({required String newTableName, required context, required List<String> columns}) async {
    if(newTableName.isNotEmpty && columns.isNotEmpty){
      final response = await client.from("user_tables").insert(
        {
          'table_name': newTableName,
          'user_id': App.supaBaseController?.client.auth.currentUser?.id,
          'table': json.encode([columns])
        },
      ).execute();
      final error = response.error;
      if (error != null) {
        if (kDebugMode) {
          print(error);
        }
        AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      }
    }
  }

  //TODO: ADD BUTTON ACTION
  insertRow({required String tableName, required Map<dynamic, dynamic> values, required context}) async {}

  insertColumn({required String tableName, required String columnName, required Map<dynamic, dynamic> table, required context}) async {
    final response = await client.from(tableName).insert(tableName).execute();
    final error = response.error;
    if (error != null) {
      print(error);
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
  }

  readData({required String table, required context, String? tableName}) async {
    final response = await client.from(table).select().execute();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if (response.status == 200 && response.data != null) {
      if(tableName != null){
        (response.data as List<dynamic>).forEach((element) {
          if(element['table_name'] == tableName) {
            return element['table'];
          }
        });
      }
      final dataResponse = response.data as List;
      return dataResponse;
    }
  }
  //TODO: UPDATE BUTTON ACTION
  updateData({required String tableName, required Map<dynamic, dynamic> values, required Map<dynamic, dynamic> matchValues, required context}) async {}

  //TODO: DELETE BUTTON ACTION
  deleteColumn({required String tableName, required String columnName, required Map<dynamic, dynamic> table, required context}) async {
    final response = await client.from(tableName).update(
        table.remove(columnName)
    ).execute();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
  }

  deleteRow({required String tableName, required Map<dynamic, dynamic> values, required context}) async {}
}