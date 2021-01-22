import 'package:flutter/material.dart';
import 'package:MethodChannel/login.dart';
import 'package:MethodChannel/home.dart';
import 'package:MethodChannel/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      Login.tag: (context) => Login(),
      SPHHome.tag: (context) => SPHHome(),
      Signup.tag: (context) => Signup(),
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
      routes: routes,
    );
  }
}
