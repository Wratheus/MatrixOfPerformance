import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/secure_storage_controller.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/login_page/login_page.dart';

import '../../feature/components/dialogs/sample_alert_dialog.dart';
import '../services/page_transition.dart';
import 'client_credentials/auth.dart';
import '../classes/app.dart';
import '../services/app_ui_modals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class  SupaBaseController {
  final SupabaseClient client = SupabaseClient(
      ClientCredentials().url, ClientCredentials().key);

  Future<bool> singUp(
      {required String email, required String password, required context}) async {
    final response = await client.auth.signUp(email, password);
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context,
          child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // error is not null, request error
    }
    if (response.user != null) {
      return true; // complete normally
    }
    return false; // any other case
  }

  Future<bool> signIn(
      {required String email, required String password, required context}) async {
    final response = await client.auth.signIn(
        email: email, password: password);
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context,
          child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // error != null
    }
    String newSession = (json.encode(
        App.supaBaseController.client.auth.session()));
    await SecureStorage.setSessionToStorage(newSession);
    return true; // complete normally
  }

  // try to recreate session with stored refresh token
  Future<bool> sessionSignIn() async {
    String? lastSession = await SecureStorage.getSessionFromStorage();
    if (lastSession != null) {
      Map<dynamic, dynamic> jsonSession = jsonDecode(lastSession);
      await App.supaBaseController.client.auth.setSession(
          jsonSession['refresh_token']);
      if (App.supaBaseController.client.auth.session() != null) {
        String newSession = (json.encode(
            App.supaBaseController.client.auth.session()));
        await SecureStorage.setSessionToStorage(newSession);
        return true; // complete normally
      }
      return false; // newSession creation failed
    }
    return false; // lastSession == null
  }

  Future<bool> signOut({required context}) async {
    final response = await client.auth.signOut();
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context,
          child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // request error, error != null
    }
    if (client.auth.currentUser == null) {
      await SecureStorage.deleteAllData();
      return true; // complete normally
    } else {
      return false; // currentUser still != null
    }
  }

  // password reset
  Future<bool> passwordReset({required context, required String email}) async {
    final response = await client.auth.api.resetPasswordForEmail(
        email,
        options: AuthOptions(
            redirectTo: 'io.supabase.flutterquickstart://reset-callback/')
    );
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context,
          child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // request error, error != null
    }
    AppUI.showMaterialModalDialog(context: context,
        child: SampleAlertDialog(alertMessageStr: 'Restore link has been send,\nCheck your e-mail box.', tittleStr: 'Success',));
    return true;
  }
 // password recovery set Auth
  Future<bool> passwordResetSetSession({required String token, context}) async {
    App.supaBaseController.client.auth.setAuth(token);
    if(App.supaBaseController.client.auth.session() == null){
      AppUI.showMaterialModalDialog(context: context,
          child: SampleErrorDialog(errorMessage: 'Something went wrong: session dispatched, try again!'));
      return false; // Session == null
    }else{
      return true;
    }
  }

  // password reset
  Future<bool> newPasswordCommit({required context, required String newPassword}) async {
    final response = await App.supaBaseController.client.auth.update(
        UserAttributes(
            password: newPassword));
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context,
          child: SampleErrorDialog(errorMessage: error.message.toString()));
      return false; // error != null
    } else {
      signOut(context: context);
      Navigator.pushReplacement(context, SlideRightRoute(page: LoginPage()));
      AppUI.showMaterialModalDialog(context: context,
          child: SampleAlertDialog(alertMessageStr: 'Your password has been changed!', tittleStr: 'Success',));
      return true; // body complete normally
    }
  }


 // creates new table
  Future<bool> insertNewTable({required String table, required String tableName, required context, required List<Map<String, dynamic>> columns}) async {
    if(tableName.isNotEmpty && columns.isNotEmpty){
      final response = await client.from(table).insert(
        {
          'table_name': tableName,
          'user_id': App.supaBaseController.client.auth.currentUser?.id,
          'table': columns
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
  Future<List<Map<String, dynamic>>> readData({required String postGreTable, required context, String? tableName}) async {
    List<Map<String, dynamic>> responseCovert = [];
    final response = await client.from(postGreTable).select().execute();
    final error = response.error;
    if (error != null) {
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if(tableName != null){
      int index = 0;
      for (var table in (response.data)) {
        if(table['table_name'] == tableName) {
          table['table'].forEach((person) {
            responseCovert.add(<String, dynamic>{});
            person.forEach((key, value) {
              responseCovert[index][key] = value;
            });
            index++;
          });
          index = 0;
          return responseCovert; // List<Map<String, dynamic>>
        }
      }
    }else{
      int index = 0;
      response.data.forEach((table) {
        List<Map<String, dynamic>> subTableItem = [];
        table['table'].forEach((person) {
          subTableItem.add(<String, dynamic>{});
          person.forEach((key, value) {
            subTableItem[index][key] = value;
          });
          index++;
        });
        index = 0;
        table['table'] = subTableItem;
        responseCovert.add(table);
      });
      return responseCovert; // List<Map<String, dynamic>>
    }
      return responseCovert; //any other case, TEST
  }
  // add update row to table
  Future<bool> updateTable({required String table, required String? tableName, required context, required List<Map<String, dynamic>> columns}) async {
    if(columns.isNotEmpty){
      final response = await client.from(table).update(
        {
          'table_name': tableName,
          'user_id': App.supaBaseController.client.auth.currentUser?.id,
          'table': columns
        },
      ).match({
        'table_name': tableName,
        'user_id': App.supaBaseController.client.auth.currentUser?.id,
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
}