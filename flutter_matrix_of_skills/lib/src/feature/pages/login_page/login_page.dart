// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_alert_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/registration_page/registration_page.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/mobile_body.dart';

import '../../../core/classes/app.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_button_style.dart';
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
      appBar: SampleAppbar(title: 'Welcome'),
      backgroundColor: defaultBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image:  DecorationImage(image: AssetImage('assets/core/images/background.jpg',),fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('Welcome\nplease login to continue', style: buttonTextColor, textAlign: TextAlign.center)),
              const SizedBox(height: 15,),
              SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, hintText: 'example@email.com'),
              const SizedBox(height: 20,),
              SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, hintText: 'you\'re password'),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async =>
                    // print('${_textControllerLogin.text}, ${_textControllerPassword.text}'),
                {
                  await App.supaBaseController?.signIn(_textControllerLogin.text, _textControllerPassword.text),
                  if(App.supaBaseController?.client.auth.currentUser != null){
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) =>
                          const ResponsiveLayout(
                              desktopBody: DesktopScaffold(),
                              mobileBody: MobileScaffold()
                              )
                            )
                          ),
                  }
                  else if(App.supaBaseController?.client.auth.currentUser == null){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SampleAlertDialog(alertMessageStr: "Wrong login or password", appBarStr: "Failed to login")))
                  },
                },
                child: SampleElevatedButtonStyleContainer(labelText: 'Login'),
              ),
              const SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                  },
                  child: Text("Register",
                    style: buttonTextColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}