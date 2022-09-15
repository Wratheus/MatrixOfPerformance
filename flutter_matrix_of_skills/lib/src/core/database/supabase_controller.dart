import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/secure_storage_controller.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';

import '../../feature/components/dialogs/sample_alert_dialog.dart';
import 'client_credentials/auth.dart';
import '../classes/app.dart';
import '../services/app_ui_modals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TODO: function return type

class SupaBaseController {
  final SupabaseClient client = SupabaseClient(ClientCredentials().url, ClientCredentials().key);

  Future<bool> singUp({required String email, required String password, required context})async{
    final response = await client.auth.signUp(email, password);
    final error = response.error;
    if(error != null){
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // error is not null, request error
    }
    if(response.user != null) {
      return true; // complete normally
    }
    return false; // any other case
  }

  Future<bool> signIn({required String email, required String password, required context}) async {
    final response = await client.auth.signIn(
        email: email, password: password);
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // error != null
    }
    String newSession = (json.encode(App.supaBaseController?.client.auth.session()));
    await SecureStorage.setSessionToStorage(newSession);
    return true; // complete normally
  }
  // try to recreate session with stored refresh token
  Future<bool> sessionSignIn() async {
    String? lastSession = await SecureStorage.getSessionFromStorage();
    if (lastSession != null) {
      Map<dynamic, dynamic> jsonSession = jsonDecode(lastSession);
      await App.supaBaseController?.client.auth.setSession(jsonSession['refresh_token']);
      if (App.supaBaseController?.client.auth.session() != null) {
        String newSession = (json.encode(App.supaBaseController?.client.auth.session()));
        await SecureStorage.setSessionToStorage(newSession);
        return true; // complete normally
      }
      return false; // newSession creation failed
    }
    return false; // lastSession == null
  }

  Future<bool> signOut({required context})async{
    final response = await client.auth.signOut();
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // request error, error != null
    }
    if(client.auth.currentUser == null) {
      await SecureStorage.deleteAllData();
      return true; // complete normally
    } else {
      return false; // currentUser still != null
    }
  }
  // password reset
  // TODO: password reset
  Future<bool> passwordReset({required context, required String email}) async{
    final response = await client.auth.api.resetPasswordForEmail(
      email,
      options: AuthOptions(redirectTo: kIsWeb
          ? null
          : 'io.supabase.flutter://reset-callback/'),
    );
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // request error, error != null
    }
    return true;
  }

 // creates new table
  Future<bool> insertNewTable({required String table, required String tableName, required context, required Map<String, dynamic> columns}) async {
    if(tableName.isNotEmpty && columns.isNotEmpty){
      final response = await client.from(table).insert(
        {
          'table_name': tableName,
          'user_id': App.supaBaseController?.client.auth.currentUser?.id,
          'table': [columns]
        },
      ).execute();
      final error = response.error;
      if (error != null) {
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
        return false; // error != null
      }else {
        return true; // body complete normally
      }
    }else{
      return false; // tableName.isEmpty or columns.isEmpty
    }
  }
 // removes table from database user_tables scheme
  Future<bool> deleteTable({required String tableName, required table, required context}) async {
    if(tableName.isNotEmpty){
      final response = await client.from(table).delete().match(
        {
          'table_name': tableName,
        },
      ).execute();
      final error = response.error;
      if (error != null) {
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
        return false; // request error, error is not null
      }
      return true; // complete normally
    }
    return false; // error, tableName not provided;
  }
// return user's table data
  Future readData({required String table, required context, String? tableName}) async {
    // TODO: subscription stream
    // Stream<List<Map<String, dynamic>>> streamResponse = client.from(table).stream(['id']).execute();
    final response = await client.from(table).select().execute();
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if(tableName != null){
      for (var element in (response.data)) {
        if(element['table_name'] == tableName) {
          return element['table']; // List<Map<String, dynamic>>
        }
      }
    }else{
      return response.data; // List<Map<String, dynamic>>
    }
      return []; //any other case, TEST
  }
  // add update row to table
  Future<bool> updateRow({required String table, required String tableName, required context, required List<dynamic> columns}) async {
    print(columns);
    if(tableName.isNotEmpty && columns.isNotEmpty){
      final response = await client.from(table).update(
        {
          'table_name': tableName,
          'user_id': App.supaBaseController?.client.auth.currentUser?.id,
          'table': columns
        },
      ).match({
        'table_name': tableName,
        'user_id': App.supaBaseController?.client.auth.currentUser?.id,
      }).execute();
      final error = response.error;
      Navigator.pop(context);
      if (error != null) {
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
        return false; // error != null
      }else {
        AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',));
        return true; // body complete normally
      }
    }else{
      return false; // tableName.isEmpty or columns.isEmpty
    }
  }

  insertColumn({required String tableName, required String columnName, required Map<dynamic, dynamic> table, required context}) async {
    final response = await client.from(tableName).insert(tableName).execute();
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
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
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
  }

  deleteRow({required String tableName, required Map<dynamic, dynamic> values, required context}) async {

  }
}