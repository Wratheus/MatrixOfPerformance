import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_error_dialog.dart';

import '../../feature/components/sample_alert_dialog.dart';
import 'client_credentials/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseController {

  final client = SupabaseClient(ClientCredentials().url, ClientCredentials().key);

  Future<bool> singUp({required String email, required String password})async{
    final response = await client.auth.signUp(email, password);
    if(response.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password, required context}) async{
    final response = await client.auth.signIn(email: email, password: password);
    final error = response.error;
    if (error != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: error.message, appBarStr: "Error")));
      return false;
    }
    return true;
  }

  Future<bool> signOut({required context})async{
    final response = await client.auth.signOut();
    final error = response.error;
    if (error != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: error.message, appBarStr: "Error")));
    }
    if(client.auth.currentUser == null) {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: error.message, appBarStr: "Error")));
    }
  }

  readData({required String table, Map<dynamic, dynamic>? values, required context}) async {
    final response = await client.from(table).select().execute();
    final error = response.error;
    if (error != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: error.message, appBarStr: "Error")));
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: error.message, appBarStr: "Error")));
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
      SampleErrorDialogPage(errorMessage: error.toString());
    }
    if (response.status == 200) {
      final dataResponse = response.data as List;
      return dataResponse;
    }
  }
}