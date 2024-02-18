class ApiUrl {
  static const String sportsMailUrl = 'https://api.sportmonks.com/v3';
  static const String weCanMailUrl = 'http://dash.thesportk.com';
  static const String auth = '?api_token=DbrVb58yhLSBbx1yJxKZx2GQnLfEMmYVUjDISnFltvWjvK0ezHhWhH9GcT6r';

  ///intro
  static const String competitions = '/competition/additional/list$auth';
  static const String scheduleAndResultsDate = '/match/diary$auth';
  static const String scheduleAndResultsSeason = '/match/season/recent$auth';
  static const String seasons = '/season/list$auth';
  static const String teams = '/team/additional/list$auth';
  // static const String playerInfo = '/player/with_stat/list$auth';
  static const String countries = '/country/list$auth';

  //test 
  static const String standings = '/football/standings/live/leagues';
  static const String teamInfo = '/football/teams';
  static const String league = '/football/leagues';
  static const String playerInfo = '/football/players';
  static const String countryInfo = '/core/countries';
  static const String seasonInfo = '/football/seasons/teams';
  static const String topScorers = '/football/topscorers/seasons';

  ///weCan url
  static const String login = '/api/login';
}
