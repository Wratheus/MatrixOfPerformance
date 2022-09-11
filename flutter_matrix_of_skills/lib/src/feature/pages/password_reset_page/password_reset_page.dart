// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/mobile_body.dart';

import '../../../core/classes/app.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';
import '../../responsive/responsive_layout.dart';
import '../login_page/login_page.dart';

class PasswordResetPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();

  PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SampleAppbar(title: 'Welcome', backgroundColor: MyColors.mainOuterColor, textColor: whiteTextColor),
      backgroundColor: MyColors.mainCanvas,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appIcon,
            const SizedBox(height: 5,),
            Center(child: Text('Enter e-mail address\n to reset your password', style: whiteTextColor, textAlign: TextAlign.center)),
            const SizedBox(height: 15,),
            SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () async =>
              {
                if (await App.supaBaseController?.signIn(email: _textControllerLogin.text, password: _textControllerPassword.text, context: context) == true){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) =>
                  const ResponsiveLayout(
                      desktopBody: DesktopScaffold(),
                      mobileBody: MobileScaffold()
                  )
                  )
                  ),
                }
              },
              child: Text('RESET', style: whiteTextColor),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () async => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                },
                child: Text('Back to login page', style: whiteTextColor)
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}