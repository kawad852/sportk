import 'package:flutter/cupertino.dart';
import 'package:sportk/model/competition_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';

class FootBallProvider extends ChangeNotifier {
  Future<CompetitionModel> fetchCompetition({
    int? page,
    int? time,
    String? uuid,
  }) {
    final snapshot = ApiService<CompetitionModel>().build(
      sportsUrl: '${ApiUrl.competitions}?page=$page&time=$time&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: CompetitionModel.fromJson,
    );
    return snapshot;
  }
}
