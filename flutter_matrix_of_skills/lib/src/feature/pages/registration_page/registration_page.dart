// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/app_ui_modals.dart';
import '../../components/dialogs/sample_alert_dialog.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_text_field.dart';
import '../login_page/login_page.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
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
              appIcon,
              const SizedBox(height: 5,),
              Center(child: Text('Complete registration to use the app', style: whiteTextColor, textAlign: TextAlign.center)),
              const SizedBox(height: 10,),
              SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              const SizedBox(height: 15,),
              SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: () async => {
                    if (await App.supaBaseController?.singUp(email: _textControllerLogin.text, password: _textControllerPassword.text, context: context) == true) {
                      AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: "Registration complete,\nCheck your email for verification", tittleStr: "Done", route: LoginPage())),
                    }
                  },
                  child: Text('Register', style: whiteTextColor)
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: () async => {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                  },
                  child: Text('Back to login page', style: whiteTextColor)
              ),
            ],
          ),
        ),
      ),
    );
  }
}