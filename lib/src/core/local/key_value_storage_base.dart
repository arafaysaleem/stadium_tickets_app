import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Base class containing a unified API for key-value pairs' storage.
/// This class provides low level methods for storing:
/// - Sensitive keys using [FlutterSecureStorage]
/// - Insensitive keys using [SharedPreferences]
class KeyValueStorageBase {
  /// Instance of shared preferences
  static SharedPreferences? _sharedPrefs;

  /// Singleton instance of KeyValueStorage Helper
  static KeyValueStorageBase? _instance;

  /// Get instance of this class
  factory KeyValueStorageBase() => _instance ?? const KeyValueStorageBase._();

  /// Private constructor
  const KeyValueStorageBase._();

  /// Initializer for shared prefs and flutter secure storage
  /// Should be called in main before runApp and
  /// after WidgetsBinding.FlutterInitialized(), to allow for synchronous tasks
  /// when possible.
  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  /// Reads the value for the key from common preferences storage
  T? getCommon<T>(String key) {
    try {
      switch (T) {
        case String:
          return _sharedPrefs!.getString(key) as T?;
        case List<String>:
          return _sharedPrefs!.getStringList(key) as T?;
        case int:
          return _sharedPrefs!.getInt(key) as T?;
        case bool:
          return _sharedPrefs!.getBool(key) as T?;
        case double:
          return _sharedPrefs!.getDouble(key) as T?;
        default:
          return _sharedPrefs!.get(key) as T?;
      }
    } on Exception catch (ex) {
      debugPrint('$ex');
      return null;
    }
  }

  /// Sets the value for the key to common preferences storage
  Future<bool> setCommon<T>(String key, T value) {
    switch (T) {
      case String:
        return _sharedPrefs!.setString(key, value as String);
      case List<String>:
        return _sharedPrefs!.setStringList(key, value as List<String>);
      case int:
        return _sharedPrefs!.setInt(key, value as int);
      case bool:
        return _sharedPrefs!.setBool(key, value as bool);
      case double:
        return _sharedPrefs!.setDouble(key, value as double);
      default:
        return _sharedPrefs!.setString(key, value as String);
    }
  }

  /// Erases common preferences keys
  Future<bool> clearCommon() => _sharedPrefs!.clear();
}
