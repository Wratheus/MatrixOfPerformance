import 'package:flutter/foundation.dart';

import 'client_credentials/auth.dart';
import 'package:supabase/supabase.dart';
// not tested made by supabase documentation


class SupaBaseController {

  final client = SupabaseClient(ClientCredentials().url, ClientCredentials().key);

  Future<bool> singUp(String email, String password)async{
    final response = await client.auth.signUp(email, password);
    if(response.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async{
    try{
      final response = await client.auth.signIn(email: email, password: password);
      final user = response.data?.user;
      if (user == null) {
        final error = response.error;
        if (kDebugMode) {
          print(error);
        }
        return false;
      }
      return true;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
  Future<bool> signOut()async{
    try{
      await client.auth.signOut();
      if (kDebugMode) {
        print(client.auth.currentUser);
      }
      if(client.auth.currentUser == null) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  insertData(String tableName, Map<dynamic, dynamic> values) async {
    try { //if (values != null)
      final response = await client.from(tableName).insert(values).execute();
      if (kDebugMode) {
        print(response.status);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  readData({required String table, Map<dynamic, dynamic>? values}) async {
    try { //if (values != null)
      final response = await client.from(table).select().execute();
      if (response.status == 200) {
        final dataResponse = response.data as List;
        if (kDebugMode) {
          print(response.data);
        }
        return dataResponse;
      } else {
        if (kDebugMode) {
          print('response status code ${response.status} error');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  updateData(String tableName, Map<dynamic, dynamic> values,
      Map<dynamic, dynamic> matchValues) async {
    try { //if (values != null)
      final response = await client.from(tableName).update(values).match(
          matchValues).execute();
      if (response.status == 200) {
        final dataResponse = response.data as List;
        if (kDebugMode) {
          print(response);
        }
        return dataResponse;
      } else {
        if (kDebugMode) {
          print('response status code ${response.status} error');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteData(String tableName, Map<dynamic, dynamic> values) async {
    try { //if (values != null)
      final response = await client.from(tableName).delete().match(values).execute();
      if (response.status == 200) {
        final dataResponse = response.data as List;
        if (kDebugMode) {
          print(response);
        }
        return dataResponse;
      } else {
        if (kDebugMode) {
          print('response status code ${response.status} error');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}