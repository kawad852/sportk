import 'package:ntp/ntp.dart';
import 'package:uuid/uuid.dart';

class MyFactory {
  // from server !!
  static Future<String> isoDate() async => await NTP.now().then((value) => value.toIso8601String());
  static String get generateId => const Uuid().v1().replaceAll('-', '');
}
