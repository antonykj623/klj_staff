import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // Singleton pattern
  static final SharedPref _instance = SharedPref._internal();
  factory SharedPref() => _instance;

  SharedPref._internal();

  SharedPreferences? _prefs;

  // Initialize SharedPreferences (call this in main)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // -----------------------------
  // SAVE values
  // -----------------------------
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  // -----------------------------
  // GET values
  // -----------------------------
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // -----------------------------
  // REMOVE a specific key
  // -----------------------------
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // -----------------------------
  // CLEAR ALL data
  // -----------------------------
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
