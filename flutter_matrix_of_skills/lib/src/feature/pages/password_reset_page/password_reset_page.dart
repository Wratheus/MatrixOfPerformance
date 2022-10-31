// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../../../core/classes/app.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_text_field.dart';
import '../login_page/login_page.dart';

class PasswordResetPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();

  PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.deepLinkController?.init(buildContext: context); // listener init
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
              onPressed: () async => await App.supaBaseController?.passwordReset(email: _textControllerLogin.text,  context: context),
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