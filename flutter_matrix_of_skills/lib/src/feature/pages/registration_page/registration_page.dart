// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/app_ui_modals.dart';
import '../../components/dialogs/sample_alert_dialog.dart';
import '../../components/sample_elevated_button.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';
import '../login_page/login_page.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
  RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: WindowBorder(
            color: MyColors.mainCanvas,
            width: 1,
            child: Row(
                children: [
                  Platform.isWindows ? RightSide(child:
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            appIcon,
                            const SizedBox(height: 5,),
                            Center(child: Text('Complete registration to use the app', style: whiteTextColor, textAlign: TextAlign.center)),
                            const SizedBox(height: 15,),
                            SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                            const SizedBox(height: 15),
                            SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: 200,
                              child: SampleElevatedButton(
                                  onPressed: () async => {
                                    if (await App.supaBaseController.singUp(email: _textControllerLogin.text, password: _textControllerPassword.text, context: context) == true) {
                                      AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: "Registration complete,\nCheck your email for verification", tittleStr: "Done", route: LoginPage())),
                                    }
                                  },
                                  child: Text('Register', style: whiteTextColor)
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SampleElevatedButton(
                                onPressed: () async => {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                                },
                                child: Text('Back', style: whiteTextColor)
                            ),
                          ],
                        ),
                  ),
                    ),
                  ) :
                  Center(
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
                          const SizedBox(height: 5,),
                          SizedBox(
                            width: 200,
                            child: SampleElevatedButton(
                                onPressed: () async => {
                                  if (await App.supaBaseController.singUp(email: _textControllerLogin.text, password: _textControllerPassword.text, context: context) == true) {
                                    AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: "Registration complete,\nCheck your email for verification", tittleStr: "Done", route: LoginPage())),
                                  }
                                },
                                child: Text('Register', style: whiteTextColor)
                            ),
                          ),
                          SampleElevatedButton(
                              onPressed: () async => {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                              },
                              child: Text('Back', style: whiteTextColor)
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}