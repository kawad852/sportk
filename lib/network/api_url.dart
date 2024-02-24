class ApiUrl {
  static const String sportsMailUrl = 'https://api.sportmonks.com/v3';
  static const String weCanMailUrl = 'http://dash.thesportk.com';
  static const String auth =
      '?api_token=cdxo3ts8WT2RbL8ovPjExCo20qnABdBZSYWO8YoEPqKMvHifLPhk1uUZWQq6';

  ///intro
  static const String competitions = '/competition/additional/list$auth';
  static const String scheduleAndResultsDate = '/match/diary$auth';
  static const String scheduleAndResultsSeason = '/match/season/recent$auth';
  static const String seasons = '/season/list$auth';
  static const String teams = '/team/additional/list$auth';
  // static const String playerInfo = '/player/with_stat/list$auth';
  static const String countries = '/country/list$auth';

  //sportmonks
  static const String standings = '/football/standings/live/leagues';
  static const String teamInfo = '/football/teams';
  static const String league = '/football/leagues';
  static const String playerInfo = '/football/players';
  static const String countryInfo = '/core/countries';
  static const String seasonInfo = '/football/seasons/teams';
  static const String topScorers = '/football/topscorers/seasons';
  static const String squads = '/football/squads/teams';
  static const String championsGroup = '/football/standings/seasons';
  static const String match = '/football/fixtures/between';
  static const String stage = '/football/stages';
  static const String compoByDate = '/football/fixtures/date';
  static const String round = '/football/rounds';

  ///weCan url
  static const String login = '/api/login';
  static const String intro = '/api/introductions';
  static const String news = '/api/blogs';
}
