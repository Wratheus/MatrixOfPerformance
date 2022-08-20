import 'package:flutter_matrix_of_skills/src/core/classes/secure_storage_controller.dart';
import 'package:flutter_matrix_of_skills/src/core/database/supabase_controller.dart';

class App{
  static  SupaBaseController? supaBaseController;
  static SecureStorage? secureStorageController;
  static Future initApp() async{
    supaBaseController = SupaBaseController();
    secureStorageController = SecureStorage();
  }
}