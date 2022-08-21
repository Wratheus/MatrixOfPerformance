// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../components/sample_alert_dialog.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_text_field.dart';
import '../login_page/login_page.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
  final TextEditingController _textControllerName = TextEditingController();
  RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SampleAppbar(title: 'Matrix of Performance', backgroundColor: MyColors.mainOuterColor, textColor: whiteTextColor),
      backgroundColor: MyColors.mainCanvas,
      body: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('Welcome to Matrix of Performance \nregister to use the app', style: whiteTextColor, textAlign: TextAlign.center)),
              const SizedBox(height: 15,),
              SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: darkTextColor),
              const SizedBox(height: 20,),
              SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, borderColor: MyColors.mainBeige, textColor: darkTextColor),
              const SizedBox(height: 20,),
              SampleTextField(textController: _textControllerName, labelText: 'Name', hideText: false, borderColor: MyColors.mainBeige, textColor: darkTextColor),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async => {
                    // print('${_textControllerLogin.text}, ${_textControllerPassword.text}'),
                    if (await App.supaBaseController?.singUp(email: _textControllerLogin.text, password: _textControllerPassword.text) == true) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: "Registration complete,\nCheck your email for verification", appBarStr: "Done", routePage: LoginPage()))),
                    } else {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: "Registration failed", appBarStr: "Failed", routePage: LoginPage(),))),
                    },
                  },
                  child: Text('Register', style: whiteTextColor)
              ),
            ],
          ),
        ),
      ),
    );
  }
}