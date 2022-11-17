// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/registration_page/registration_page.dart';

import '../../../core/classes/app.dart';
import '../../../core/services/page_transition.dart';
import '../../components/sample_elevated_button.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';
import '../../responsive/responsive_layout.dart';
import '../password_reset_page/password_reset_page.dart';

class LoginPage extends StatelessWidget {

  void loginAction({required String email, required String password, required context}) async{
    if (await App.supaBaseController.signIn(email: email, password: password, context: context) == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>
            const ResponsiveLayout(
            )
          )
      );
    }
  }
  // Init
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainOuterColor,
        body: Platform.isWindows ?  WindowBorder(
          color: MyColors.mainCanvas,
          width: 1,
          child: Stack(
              children: [
                RightSide(
                    child: Container(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    appIcon,
                    const SizedBox(height: 5,),
                    Center(child: Text('Welcome\nplease login to continue', style: whiteTextColor, textAlign: TextAlign.center)),
                    const SizedBox(height: 15,),
                    SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                    const SizedBox(height: 10,),
                    SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                    const SizedBox(height: 15,),
                    SampleElevatedButton(
                      onPressed: () {loginAction(email: _textControllerLogin.text, password: _textControllerPassword.text, context: context);},
                      child: Text('Login', style: whiteTextColor),
                    ),
                    const SizedBox(height: 10,),
                    Center(
                      child: InkWell(
                        radius: 0,
                        onTap: () { Navigator.pushReplacement(context, SlideRightRoute(page: RegistrationPage()));},
                        child: Text("Register",
                          style: whiteTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: InkWell(
                        radius: 0,
                        onTap: () { Navigator.pushReplacement(context, SlideRightRoute(page: PasswordResetPage()));},
                        child: Text("Forgot password",
                          style: greyTextColor,
                        ),
                      ),
                    )
                  ],
                ),
              ]
          )
        )
            :   //mobile
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appIcon,
              const SizedBox(height: 5,),
              Center(child: Text('Welcome\nplease login to continue', style: whiteTextColor, textAlign: TextAlign.center)),
              const SizedBox(height: 15,),
              SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              const SizedBox(height: 10,),
              SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              const SizedBox(height: 15,),
              SampleElevatedButton(
                onPressed: () {loginAction(email: _textControllerLogin.text, password: _textControllerPassword.text, context: context);},
                child: Text('Login', style: whiteTextColor),
              ),
              const SizedBox(height: 10,),
              Center(
                child: InkWell(
                  radius: 0,
                  onTap: () { Navigator.pushReplacement(context, SlideRightRoute(page: RegistrationPage()));},
                  child: Text("Register",
                    style: whiteTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: InkWell(
                  radius: 0,
                  onTap: () { Navigator.pushReplacement(context, SlideRightRoute(page: PasswordResetPage()));},
                  child: Text("Forgot password",
                    style: greyTextColor,
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}