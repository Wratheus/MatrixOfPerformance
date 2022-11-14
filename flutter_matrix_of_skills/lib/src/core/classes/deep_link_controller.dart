import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/classes/app.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/password_reset_page/new_password_page.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_links/uni_links.dart';

import '../services/page_transition.dart';


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
            RegExp regExp = RegExp("refresh_token=(.*)");
            String? match = regExp.firstMatch(url)?.group(1);
            if(match != null) {
              String refreshToken = match.substring(0, match.indexOf('&'));
            redirectPasswordReset(token: refreshToken, context: context);
            }else{
              redirectPasswordReset(token: 'error', context: context);
            }
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
        Navigator.pushReplacement(context, SlideRightRoute(page: NewPasswordPage(refreshToken: token))));
  }
}
