import 'package:sportk/utils/shared_pref.dart';

class LanguageEnum {
  static const String english = 'en';
  static const String arabic = 'ar';
}

class ThemeEnum {
  static const String light = 'light';
  static const String dark = 'dark';
}

class LocationEnum {
  static const String home = 'home';
  static const String away = 'away';
}

class LeagueTypeEnum {
  static const String domestic = 'domestic';
  static const String cubInternational = 'cup_international';
}

class CompoTypeEnum {
  static const String teams = '1';
  static const String competitions = '2';
  static const String blogs = '3';
}

class BlogsType {
  static String recommended = 'user?locale=${MySharedPreferences.language}';
  static String mostRecent = '?locale=${MySharedPreferences.language}';
  static String teams(int id) => 'teams/$id?locale=${MySharedPreferences.language}';
  static String competitions(int id) => 'tags/$id?locale=${MySharedPreferences.language}';
}
