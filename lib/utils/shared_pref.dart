import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/utils/enums.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void clearStorage() {
    user = AuthModel.fromJson(AuthModel().toJson());
  }

  static AuthModel get user {
    String value = _sharedPreferences.getString('userModel') ?? '';
    var authModel = AuthModel();
    if (value.isNotEmpty) {
      authModel = AuthModel.fromJson(jsonDecode(value));
    }
    return authModel;
  }

  static set user(AuthModel value) {
    _sharedPreferences.setString('userModel', jsonEncode(value.toJson()));
  }

  static void saveUser(AuthModel adminModel) {
    user = AuthModel.fromJson(adminModel.toJson());
  }

  static String get language => _sharedPreferences.getString('language') ?? LanguageEnum.english;
  static set language(String value) => _sharedPreferences.setString('language', value);

  static String get theme => _sharedPreferences.getString('theme') ?? ThemeEnum.light;
  static set theme(String value) => _sharedPreferences.setString('theme', value);

  static bool get isPassedIntro => _sharedPreferences.getBool('isPassedIntro') ?? false;
  static set isPassedIntro(bool value) => _sharedPreferences.setBool('isPassedIntro', value);
}
