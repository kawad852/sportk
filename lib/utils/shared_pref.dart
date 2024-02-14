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
    user = UserModel.fromJson(UserModel().toJson());
  }

  static UserModel get user {
    String value = _sharedPreferences.getString('userModel') ?? '';
    var authModel = UserModel();
    if (value.isNotEmpty) {
      authModel = UserModel.fromJson(jsonDecode(value));
    }
    return authModel;
  }

  static set user(UserModel value) {
    _sharedPreferences.setString('userModel', jsonEncode(value.toJson()));
  }

  static void saveUser(UserModel adminModel) {
    user = UserModel.fromJson(adminModel.toJson());
  }

  static String get language => _sharedPreferences.getString('language') ?? LanguageEnum.english;
  static set language(String value) => _sharedPreferences.setString('language', value);

  static String get theme => _sharedPreferences.getString('theme') ?? ThemeEnum.light;
  static set theme(String value) => _sharedPreferences.setString('theme', value);

  static bool get isPassedIntro => _sharedPreferences.getBool('isPassedIntro') ?? false;
  static set isPassedIntro(bool value) => _sharedPreferences.setBool('isPassedIntro', value);
}
