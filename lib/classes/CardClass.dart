import 'dart:async';
import 'package:flutter/services.dart';

class CardClass {
  static const MethodChannel _channel = const MethodChannel('sph.flutter.dev');

  static Future<String> getCardListing() async {
    final String status = await _channel.invokeMethod('getCardDetails');
    return status;
  }
}
