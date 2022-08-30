import 'dart:convert';

import 'package:flutter_matrix_of_skills/src/core/classes/secure_storage_controller.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_error_dialog.dart';

import '../classes/app.dart';
import '../services/app_ui_modals.dart';
import 'client_credentials/auth.dart';
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
  //TODO: ADD BUTTON ACTION
  insertData({required String tableName, required Map<dynamic, dynamic> values, required context}) async {
    final response = await client.from(tableName).insert(values).execute();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
  }

  readData({required String table, Map<dynamic, dynamic>? values, required context}) async {
    final response = await client.from(table).select().execute();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if (response.status == 200) {
      final dataResponse = response.data as List;
      return dataResponse;
    }
  }
  //TODO: UPDATE BUTTON ACTION
  updateData({required String tableName, required Map<dynamic, dynamic> values, required Map<dynamic, dynamic> matchValues, required context}) async {
    final response = await client.from(tableName).update(values).match(
        matchValues).execute();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if (response.status == 200) {
      final dataResponse = response.data as List;
      return dataResponse;
    }
  }
  //TODO: DELETE BUTTON ACTION
  deleteData({required String tableName, required Map<dynamic, dynamic> values, required context}) async {
    final response = await client.from(tableName).delete().match(values).execute();
    final error = response.error;
    if (error != null) {
      AppUI.showCupertinoModalDialog(context: context, child: SampleErrorDialog(errorMessage: error.message.toString()));
    }
    if (response.status == 200) {
      final dataResponse = response.data as List;
      return dataResponse;
    }
  }
}