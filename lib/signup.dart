import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MethodChannel/home.dart';
import 'package:MethodChannel/values/dimen.dart';
import 'package:MethodChannel/values/string.dart';
import 'package:MethodChannel/classes/loginClass.dart';

class Signup extends StatefulWidget {
  static String tag = 'signup';

  @override
  SignupState createState() => SignupState();
//  _LoginPageState createState() => _LoginPageState();
}

class SignupState extends State<Signup> {
  final usernameCont = TextEditingController();
  final passwordCont = TextEditingController();
  final emailCont = TextEditingController();

  bool _buttonStatus = false;

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      controller: usernameCont,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          hintText: Strings.USERNAME_HINT,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  Dimensions.INPUT_WIDGET_CORNER_RADIUS))),
    );

    final email = TextFormField(
      controller: emailCont,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: Strings.EMAIL_HINT,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  Dimensions.INPUT_WIDGET_CORNER_RADIUS))),
    );

    final password = TextFormField(
      controller: passwordCont,
      keyboardType: TextInputType.text,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
          hintText: Strings.PASS_HINT,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  Dimensions.INPUT_WIDGET_CORNER_RADIUS))),
    );

    final registerButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: !_buttonStatus ? _onLoginPressed : () {},
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.BUTTON_CORNER_RADIUS)),
          padding: EdgeInsets.all(12),
          color: Colors.blue.shade300,
          child: Text(
            Strings.BUTTON_TEXT_SIGNUP,
            style: TextStyle(color: Colors.white),
          ),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(Strings.BUTTON_TEXT_SIGNUP),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            username,
            SizedBox(height: 30.0),
            email,
            SizedBox(height: 30.0),
            password,
            SizedBox(height: 48.0),
            registerButton,
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    final String username = usernameCont.text;
    final String password = passwordCont.text;
    final String email = emailCont.text;
    _signInUser(username, password, email);
  }

  void _signInUser(String username, String password, String email) async {
    if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
      setState(() {
        _buttonStatus = true;
      });
      final bool status =
          await SignInSignUpClass.registerUser(username, password, email);
      if (status) {
        Navigator.of(context).pushNamed(SPHHome.tag);
      }
      setState(() {
        _buttonStatus = true;
      });
    }
  }
}
