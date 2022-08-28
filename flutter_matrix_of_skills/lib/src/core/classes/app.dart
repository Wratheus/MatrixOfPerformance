import 'package:flutter_matrix_of_skills/src/core/database/supabase_controller.dart';

class App{
  static  SupaBaseController? supaBaseController;
  static bool? session;
  static initApp() {
    supaBaseController = SupaBaseController();
  }
}