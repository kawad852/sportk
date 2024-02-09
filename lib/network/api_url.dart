class ApiUrl {
  static const String mainUrl = 'https://api.sportmonks.com/v3/football';
  static const String auth = '?api_token=DbrVb58yhLSBbx1yJxKZx2GQnLfEMmYVUjDISnFltvWjvK0ezHhWhH9GcT6r';

  ///intro
  static const String competitions = '/competition/additional/list$auth';
  static const String scheduleAndResultsDate = '/match/diary$auth';
  static const String scheduleAndResultsSeason = '/match/season/recent$auth';
  static const String seasons = '/season/list$auth';
  static const String teams = '/team/additional/list$auth';
  static const String playerInfo = '/player/with_stat/list$auth';
  static const String countries = '/country/list$auth';


  //test
  static const String standings = '/standings/live/leagues';
  static const String teamInfo = '/teams';
  static const String league = '/leagues';





}
