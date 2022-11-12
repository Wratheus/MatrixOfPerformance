import 'package:flutter_matrix_of_skills/src/core/database/supabase_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/client_credentials/auth.dart';
import 'deep_link_controller.dart';

class App{
  static SupaBaseController supaBaseController = SupaBaseController();
  static DeepLinkController deepLinkController = DeepLinkController();
  static bool? session;
  static Supabase? supabase;
  static initApp() async{
    await Supabase.initialize(
      url: ClientCredentials.url,
      anonKey: ClientCredentials.key,
    );
  }
}