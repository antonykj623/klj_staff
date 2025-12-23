
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kljcafe_staff_new/web/api_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';
// #docregion migrate
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';
// #enddocregion migrate


class SharedPref {
  // Singleton pattern


  // Initialize SharedPreferences (call this in main)
  // Future<void> init() async {
  //
  // }

  // -----------------------------
  // SAVE values
  // -----------------------------
  // static SaveToken(String key,String data)
  // async {
  //
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.setString(key, data);
  // }
  //
  // static Future<String?> getString(String key)
  // async {
  //   final  prefs = await SharedPreferences.getInstance();
  //
  //   String? a=  await prefs.getString(key);
  //
  //   return a;
  //
  // }
  //
  // static setString(String key,String data)
  // async {
  //
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.setString(key, data);
  // }

  static const MethodChannel _channel =
  MethodChannel('native_prefs');

  static Future<void> setString(String key, String value) async {
    await _channel.invokeMethod('setString', {
      'key': key,
      'value': value,
    });
  }

  static Future<String?> getString(String key) async {
    final result = await _channel.invokeMethod<String>(
      'getString',
      {'key': key},
    );
    return result;
  }

  // -----------------------------
  // REMOVE a specific key
  // -----------------------------

}
