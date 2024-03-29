import 'package:sportk/utils/enums.dart';

class MatchEventModel {
  String locationEnum;
  MatchEventEnum matchEventEnum;
  String? playerName1;
  String? playerName2;
  String? playerImage;
  String? eventName;
  int? minute;

  MatchEventModel({
    required this.locationEnum,
    required this.matchEventEnum,
    this.playerName1,
    this.playerName2,
    this.playerImage,
    this.eventName,
    this.minute,
  });
}
