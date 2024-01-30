class ApiUrl {
  static const String mainUrl = 'https://api.thesports.com/v1/football';
  static const String auth = '?user=doosh&secret=fed77cef9b6a8382207b047604960e3c';

  ///intro
  static const String competitions = '/competition/additional/list$auth';
  static const String scheduleAndResultsDate = '/match/diary$auth';
  static const String scheduleAndResultsSeason = '/match/season/recent$auth';
  static const String seasons = '/season/list$auth';
  static const String teams = '/team/additional/list$auth';
  static const String playerInfo = '/player/with_stat/list$auth';

}
