// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/registration_page/registration_page.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/mobile_body.dart';

import '../../../core/classes/app.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';
import '../../responsive/responsive_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
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
            Center(child: Text('Welcome\nplease login to continue', style: whiteTextColor, textAlign: TextAlign.center)),
            const SizedBox(height: 15,),
            SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor),
            const SizedBox(height: 20,),
            SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, borderColor: MyColors.mainBeige, textColor: whiteTextColor),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async =>
                  // print('${_textControllerLogin.text}, ${_textControllerPassword.text}'),
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
              child: Text('Login', style: whiteTextColor),
            ),
            const SizedBox(height: 10,),
            Center(
              child: InkWell(
                onTap: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                },
                child: Text("Register",
                  style: whiteTextColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}