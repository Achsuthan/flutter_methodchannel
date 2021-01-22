import 'dart:async';
import 'package:flutter/services.dart';

class SignInSignUpClass {
  static const MethodChannel _channel = const MethodChannel('sph.flutter.dev');

  static Future<bool> loginUser(String username, String password) async {
    final bool status = await _channel.invokeMethod('login', {
      "userName": username,
      "password": password,
    });
    return status;
  }

  static Future<bool> registerUser(
      String username, String emailAddress, String password) async {
    final bool status = await _channel.invokeMethod('register', {
      "userName": emailAddress,
      "password": password,
      "emailAddress": emailAddress
    });
    return status;
  }

  static Future<bool> getUserLoggedIn() async {
    final bool status = await _channel.invokeMethod('getUserLoggedIn');
    return status;
  }

  static Future<bool> logoutUser() async {
    final bool status = await _channel.invokeMethod('logoutUser');
    return status;
  }
}
