import 'package:flutter/cupertino.dart';
import 'package:sportk/model/champions_groups_model.dart';
import 'package:sportk/model/country_info_model.dart';
import 'package:sportk/model/groups_standing_model.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/model/player_statistics_model.dart';
import 'package:sportk/model/season_by_league_model.dart';
import 'package:sportk/model/season_info_model.dart';
import 'package:sportk/model/squads_model.dart';
import 'package:sportk/model/stage_model.dart';
import 'package:sportk/model/standings_model.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';

class FootBallProvider extends ChangeNotifier {
  Future<LeagueByDateModel> fetchLeagueByDate({
    required String date,
    required int leagueId,
  }) {
    final snapshot = ApiService<LeagueByDateModel>().build(
      sportsUrl: '${ApiUrl.compoByDate}/$date?filters=fixtureLeagues:$leagueId&&include=participants;statistics.type',
      isPublic: true,
      apiType: ApiType.get,
      builder: PlayerModel.fromJson,
    );
    return snapshot;
  }

  Future<PlayerModel> fetchPlayerInfo({
    required int playerId,
  }) {
    final snapshot = ApiService<PlayerModel>().build(
      sportsUrl: '${ApiUrl.playerInfo}/$playerId${ApiUrl.auth}&include=teams',
      isPublic: true,
      apiType: ApiType.get,
      builder: PlayerModel.fromJson,
    );
    return snapshot;
  }

  Future<CountryInfoModel> fetchCountry({
    required int countryId,
  }) {
    final snapshot = ApiService<CountryInfoModel>().build(
      sportsUrl: '${ApiUrl.countryInfo}/$countryId${ApiUrl.auth}',
      isPublic: true,
      apiType: ApiType.get,
      builder: CountryInfoModel.fromJson,
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

  Future<SeasonInfoModel> fetchSeasonsByTeam({
    required int teamId,
  }) {
    final snapshot = ApiService<SeasonInfoModel>().build(
      sportsUrl: '${ApiUrl.seasonInfo}/$teamId${ApiUrl.auth}',
      isPublic: true,
      apiType: ApiType.get,
      builder: SeasonInfoModel.fromJson,
    );
    return snapshot;
  }

  Future<PlayerStatisticsModel> fetchPlayerStatistics({
    required int playerId,
    required int seasonId,
  }) {
    final snapshot = ApiService<PlayerStatisticsModel>().build(
      sportsUrl: '${ApiUrl.playerInfo}/$playerId${ApiUrl.auth}&include=statistics.details&filters=playerStatisticSeasons:$seasonId',
      isPublic: true,
      apiType: ApiType.get,
      builder: PlayerStatisticsModel.fromJson,
    );
    return snapshot;
  }

  Future<TopScorersModel> fetchTopScorers({
    required int seasonId,
    required int pageKey,
  }) {
    final snapshot = ApiService<TopScorersModel>().build(
      sportsUrl: '${ApiUrl.topScorers}/$seasonId${ApiUrl.auth}&include=player&filters=seasonTopscorerTypes:208&page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: TopScorersModel.fromJson,
    );
    return snapshot;
  }

  Future<SeasonByLeagueModel> fetchSeasonByLeague({
    required int leagueId,
  }) {
    final snapshot = ApiService<SeasonByLeagueModel>().build(
      sportsUrl: '${ApiUrl.league}/$leagueId${ApiUrl.auth}&include=currentSeason',
      isPublic: true,
      apiType: ApiType.get,
      builder: SeasonByLeagueModel.fromJson,
    );
    return snapshot;
  }

  Future<SquadsModel> fetchSquads({
    required int teamId,
  }) {
    final snapshot = ApiService<SquadsModel>().build(
      sportsUrl: '${ApiUrl.squads}/$teamId${ApiUrl.auth}&include=player',
      isPublic: true,
      apiType: ApiType.get,
      builder: SquadsModel.fromJson,
    );
    return snapshot;
  }

  Future<TeamInfoModel> fetchTeamSeasons({
    required int teamId,
  }) {
    final snapshot = ApiService<TeamInfoModel>().build(
      sportsUrl: '${ApiUrl.teamInfo}/$teamId${ApiUrl.auth}&include=seasons',
      isPublic: true,
      apiType: ApiType.get,
      builder: TeamInfoModel.fromJson,
    );
    return snapshot;
  }

  Future<ChampionsGroupsModel> fetchChampionsGroup({
    required int seasonId,
  }) {
    final snapshot = ApiService<ChampionsGroupsModel>().build(
      sportsUrl: '${ApiUrl.championsGroup}/$seasonId${ApiUrl.auth}&include=group',
      isPublic: true,
      apiType: ApiType.get,
      builder: ChampionsGroupsModel.fromJson,
    );
    return snapshot;
  }

  Future<GroupsStandingModel> fetchGroupStandings({
    required int seasonId,
    required int groupId,
  }) {
    final snapshot = ApiService<GroupsStandingModel>().build(
      sportsUrl: '${ApiUrl.championsGroup}/$seasonId${ApiUrl.auth}&include=group;details.type&filters=standingGroups:$groupId',
      isPublic: true,
      apiType: ApiType.get,
      builder: GroupsStandingModel.fromJson,
    );
    return snapshot;
  }

  Future<MatchModel> fetchMatchesBetweenTwoDate({
    required String startDate,
    required String endDate,
    required int leagueId,
    required int pageKey
  }) {
    final snapshot = ApiService<MatchModel>().build(
      sportsUrl: '${ApiUrl.match}/$startDate/$endDate${ApiUrl.auth}&include=statistics;state;participants&filters=fixtureLeagues:$leagueId&page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: MatchModel.fromJson,
    );
    return snapshot;
  }

  Future<StageModel> fetchStage({
    required int stageId,
  }) {
    final snapshot = ApiService<StageModel>().build(
      sportsUrl: '${ApiUrl.stage}/$stageId${ApiUrl.auth}',
      isPublic: true,
      apiType: ApiType.get,
      builder: StageModel.fromJson,
    );
    return snapshot;
  }

  Future<StageModel> fetchRound({
    required int roundId,
  }) {
    final snapshot = ApiService<StageModel>().build(
      sportsUrl: '${ApiUrl.round}/$roundId${ApiUrl.auth}',
      isPublic: true,
      apiType: ApiType.get,
      builder: StageModel.fromJson,
    );
    return snapshot;
  }

  Future<MatchModel> fetchTeamMatchesBetweenTwoDate({
    required String startDate,
    required String endDate,
    required int teamId,
    required int pageKey,

  }) {
    final snapshot = ApiService<MatchModel>().build(
      sportsUrl: '${ApiUrl.match}/$startDate/$endDate/$teamId${ApiUrl.auth}&include=statistics;state;participants&page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: MatchModel.fromJson,
    );
    return snapshot;
  }
}
