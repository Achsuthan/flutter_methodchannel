import 'package:MethodChannel/classes/loginClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MethodChannel/home.dart';
import 'package:MethodChannel/values/dimen.dart';
import 'package:MethodChannel/values/string.dart';
import 'package:MethodChannel/signup.dart';

class Login extends StatefulWidget {
  static String tag = 'login';

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final usernameCont = TextEditingController();
  final passwordCont = TextEditingController();
  bool _buttonStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    checkUserStatus();
  }

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

    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: !_buttonStatus ? _onLoginPressed : () {},
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.BUTTON_CORNER_RADIUS)),
          padding: EdgeInsets.all(12),
          color: Colors.blue.shade300,
          child: Text(
            Strings.BUTTON_TEXT_LOGIN,
            style: TextStyle(color: Colors.white),
          ),
        ));
    final signupButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: _onSignupPressed,
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
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            username,
            SizedBox(height: 30.0),
            password,
            SizedBox(
              height: 48.0,
              width: 48.0,
            ),
            loginButton,
            signupButton,
          ],
        ),
      ),
    );
  }

  void _onSignupPressed() {
    Route signUp = MaterialPageRoute(builder: (context) => Signup());
    Navigator.push(context, signUp);
  }

  void _onLoginPressed() {
    final String username = usernameCont.text;
    final String password = passwordCont.text;
    _signInUser(username, password);
  }

  void _signInUser(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _buttonStatus = true;
      });
      final bool status = await SignInSignUpClass.loginUser(username, password);
      if (status) {
        Navigator.of(context).pushNamed(SPHHome.tag);
      }
      setState(() {
        _buttonStatus = false;
      });
    }
  }

  checkUserStatus() async {
    final bool status = await SignInSignUpClass.getUserLoggedIn();
    if (status) {
      Navigator.of(context).pushNamed(SPHHome.tag);
    }
  }
}
