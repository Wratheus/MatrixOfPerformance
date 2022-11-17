import 'package:flutter_matrix_of_skills/src/core/database/supabase_controller.dart';
import 'deep_link_controller.dart';

class App{
  static bool sessionSignIn = false;
  static int currentPageIndex = 0;
  static SupaBaseController supaBaseController = SupaBaseController();
  static DeepLinkController deepLinkController = DeepLinkController();
}