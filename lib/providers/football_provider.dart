import 'package:flutter/cupertino.dart';
import 'package:sportk/model/competition_model.dart';
import 'package:sportk/model/country_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/model/schedule_and_results_season_model.dart';
import 'package:sportk/model/season_model.dart';
import 'package:sportk/model/standings_model.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/model/team_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';

class FootBallProvider extends ChangeNotifier {
  Future<CompetitionModel> fetchCompetitions({
    int? page,
    int? time,
    String? uuid,
  }) {
    final snapshot = ApiService<CompetitionModel>().build(
      sportsUrl: '${ApiUrl.competitions}&page=$page&time=$time&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: CompetitionModel.fromJson,
    );
    return snapshot;
  }

  Future<CompetitionModel> fetchPlayers({
    int? page,
    int? time,
    String? uuid,
  }) {
    final snapshot = ApiService<CompetitionModel>().build(
      sportsUrl: '${ApiUrl.competitions}&page=$page&time=$time&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: CompetitionModel.fromJson,
    );
    return snapshot;
  }

  Future<SeasonModel> fetchSeasons({
    int? page,
    int? time,
    String? uuid,
  }) {
    final snapshot = ApiService<SeasonModel>().build(
      sportsUrl: '${ApiUrl.seasons}&page=$page&time=$time&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: SeasonModel.fromJson,
    );
    return snapshot;
  }

  Future<ScheduleAndResultsSeasonModel> fetchRescheduleAndResultsSeasons({
    String? uuid,
  }) {
    final snapshot = ApiService<ScheduleAndResultsSeasonModel>().build(
      sportsUrl: '${ApiUrl.scheduleAndResultsSeason}&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: ScheduleAndResultsSeasonModel.fromJson,
    );
    return snapshot;
  }

  Future<TeamModel> fetchTeams({
    int? page,
    int? time,
    String? uuid,
  }) {
    final snapshot = ApiService<TeamModel>().build(
      sportsUrl: '${ApiUrl.teams}&page=$page&time=$time&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: TeamModel.fromJson,
    );
    return snapshot;
  }

  Future<PlayerModel> fetchPlayerInfo({
    int? page,
    int? time,
    String? uuid,
  }) {
    final snapshot = ApiService<PlayerModel>().build(
      sportsUrl: '${ApiUrl.playerInfo}&page=$page&time=$time&uuid=$uuid',
      isPublic: true,
      apiType: ApiType.get,
      builder: PlayerModel.fromJson,
    );
    return snapshot;
  }

  Future<CyModel> fetchCountry({
    int? page,
    int? time,
  }) {
    final snapshot = ApiService<CyModel>().build(
      sportsUrl: '${ApiUrl.countries}&page=$page&time=$time',
      isPublic: true,
      apiType: ApiType.get,
      builder: CyModel.fromJson,
    );
    return snapshot;
  }

  Future<StandingsModel> fetchStandings({
    required int leagueId,
  }) {
    final snapshot = ApiService<StandingsModel>().build(
      sportsUrl: '${ApiUrl.standings}/$leagueId${ApiUrl.auth}&include=details.type',
      isPublic: true,
      apiType: ApiType.get,
      builder: StandingsModel.fromJson,
    );
    return snapshot;
  }

  Future<TeamInfoModel> fetchTeamInfo({
    required int teamId,
  }) {
    final snapshot = ApiService<TeamInfoModel>().build(
      sportsUrl: '${ApiUrl.teamInfo}/$teamId${ApiUrl.auth}',
      isPublic: true,
      apiType: ApiType.get,
      builder: TeamInfoModel.fromJson,
    );
    return snapshot;
  }


  Future<LeagueModel> fetchLeague({
    required int leagueId,
  }) {
    final snapshot = ApiService<LeagueModel>().build(
      sportsUrl: '${ApiUrl.league}/$leagueId${ApiUrl.auth}',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueModel.fromJson,
    );
    return snapshot;
  }
}
