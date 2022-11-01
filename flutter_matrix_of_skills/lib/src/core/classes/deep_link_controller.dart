import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/password_reset_page/new_password_page.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:uni_links/uni_links.dart';


class DeepLinkController {
  late BuildContext context;
  void init({required buildContext}) {
    context = buildContext;
    if (Platform.isWindows) {
      // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
      StreamSubscription? _windowsSub;
      registerProtocol('io.supabase.flutterquickstart');
      if (!kIsWeb) { // windows web link listener
        _windowsSub = uriLinkStream.listen((Uri? uri) {
          String url = uri.toString();
          if(url.substring(url.length - 8) == 'recovery'){
            String accessToken = url.substring(url.indexOf('=') + 1, url.indexOf('&'));
            redirectPasswordReset(token: accessToken, context: context);
          }
        }, onError: (Object err) {
        });
      }
    } else {
      // TODO: Android/IOS block
    }
  }

  void redirectPasswordReset({required String token, required context}) async{
    App.supaBaseController.passwordResetSetSession(token: token).then((value) =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewPasswordPage(refreshToken: token))));
  }
}
