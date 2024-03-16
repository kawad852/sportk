import 'package:flutter/cupertino.dart';
import 'package:sportk/model/champions_groups_model.dart';
import 'package:sportk/model/country_info_model.dart';
import 'package:sportk/model/groups_standing_model.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/league_search_model.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/model/player_search_model.dart';
import 'package:sportk/model/player_statistics_model.dart';
import 'package:sportk/model/season_by_league_model.dart';
import 'package:sportk/model/season_info_model.dart';
import 'package:sportk/model/squads_model.dart';
import 'package:sportk/model/stage_model.dart';
import 'package:sportk/model/standings_model.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/model/team_search_model.dart';
import 'package:sportk/model/teams_by_season_model.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/base_extensions.dart';

class FootBallProvider extends ChangeNotifier {
  /// whether all competitions at home don't return any matches
  List<bool> competitionIds = [];

  void toggleList(bool status) {
    competitionIds.add(status);
  }

  void setTheState() {
    notifyListeners();
  }

  bool get isEveryCompoEmpty => competitionIds.every((element) => element);

  ///...

  Future<PlayerModel> fetchPlayerInfo({
    required int playerId,
  }) {
    final snapshot = ApiService<PlayerModel>().build(
      sportsUrl: '${ApiUrl.playerInfo}/$playerId${ApiUrl.auth}&include=teams&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.countryInfo}/$countryId${ApiUrl.auth}&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.standings}/$leagueId${ApiUrl.auth}&include=details.type&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.teamInfo}/$teamId${ApiUrl.auth}&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.league}/$leagueId${ApiUrl.auth}&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueModel.fromJson,
    );
    return snapshot;
  }

  Future<LeagueByDateModel> fetchLeagueByDate(BuildContext context, DateTime date, int id) {
    final snapshot = ApiService<LeagueByDateModel>().build(
      sportsUrl: '${ApiUrl.compoByDate}/${date.formatDate(context, pattern: 'yyyy-MM-dd')}${ApiUrl.auth}&filters=fixtureLeagues:$id&include=statistics;state;participants;periods.events&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueByDateModel.fromJson,
    );
    return snapshot;
  }

  Future<LeagueByDateModel> fetchLeagueByTeam(BuildContext context, DateTime date, int id) {
    final snapshot = ApiService<LeagueByDateModel>().build(
      sportsUrl: '${ApiUrl.leagueByTeam}/${date.formatDate(context, pattern: 'yyyy-MM-dd')}/${date.formatDate(context, pattern: 'yyyy-MM-dd')}${ApiUrl.auth}&include=statistics;state;participants;periods.events&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueByDateModel.fromJson,
    );
    return snapshot;
  }

  Future<SeasonInfoModel> fetchSeasonsByTeam({
    required int teamId,
  }) {
    final snapshot = ApiService<SeasonInfoModel>().build(
      sportsUrl: '${ApiUrl.seasonInfo}/$teamId${ApiUrl.auth}&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.playerInfo}/$playerId${ApiUrl.auth}&include=statistics.details&filters=playerStatisticSeasons:$seasonId&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.topScorers}/$seasonId${ApiUrl.auth}&include=player&filters=seasonTopscorerTypes:208&page=$pageKey&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.league}/$leagueId${ApiUrl.auth}&include=currentSeason&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: SeasonByLeagueModel.fromJson,
    );
    return snapshot;
  }

  Future<TeamsBySeasonModel> fetchTeamsBySeason({
    required int seasonId,
  }) {
    final snapshot = ApiService<TeamsBySeasonModel>().build(
      sportsUrl: '${ApiUrl.teamsBySeason}/$seasonId${ApiUrl.auth}&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: TeamsBySeasonModel.fromJson,
    );
    return snapshot;
  }

  Future<SquadsModel> fetchSquads({
    required int teamId,
  }) {
    final snapshot = ApiService<SquadsModel>().build(
      sportsUrl: '${ApiUrl.squads}/$teamId${ApiUrl.auth}&include=player&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.teamInfo}/$teamId${ApiUrl.auth}&include=seasons&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.championsGroup}/$seasonId${ApiUrl.auth}&include=group&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.championsGroup}/$seasonId${ApiUrl.auth}&include=group;details.type&filters=standingGroups:$groupId&${ApiUrl.locale}',
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
    required int pageKey,
  }) {
    final snapshot = ApiService<MatchModel>().build(
      sportsUrl: '${ApiUrl.match}/$startDate/$endDate${ApiUrl.auth}&include=statistics;state;participants;periods.events&filters=fixtureLeagues:$leagueId&page=$pageKey&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.stage}/$stageId${ApiUrl.auth}&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.round}/$roundId${ApiUrl.auth}&${ApiUrl.locale}',
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
      sportsUrl: '${ApiUrl.match}/$startDate/$endDate/$teamId${ApiUrl.auth}&include=statistics;state;participants;periods.events&page=$pageKey&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: MatchModel.fromJson,
    );
    return snapshot;
  }

  Future<LeagueSearchModel> searchLeagues({
    required String query,
  }) {
    final snapshot = ApiService<LeagueSearchModel>().build(
      sportsUrl: '${ApiUrl.leagueSearch}/$query${ApiUrl.auth}&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueSearchModel.fromJson,
    );
    return snapshot;
  }

  Future<TeamSearchModel> searchTeams({
    required String query,
  }) {
    final snapshot = ApiService<TeamSearchModel>().build(
      sportsUrl: '${ApiUrl.teamsSearch}/$query${ApiUrl.auth}&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: TeamSearchModel.fromJson,
    );
    return snapshot;
  }

  Future<PlayerSearchModel> searchPlayers({
    required String query,
  }) {
    final snapshot = ApiService<PlayerSearchModel>().build(
      sportsUrl: '${ApiUrl.playersSearch}/$query${ApiUrl.auth}&${ApiUrl.locale}',
      isPublic: true,
      apiType: ApiType.get,
      builder: PlayerSearchModel.fromJson,
    );
    return snapshot;
  }
}
