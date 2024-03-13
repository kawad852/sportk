class ApiUrl {
  static const String sportsMailUrl = 'https://api.sportmonks.com/v3';
  static const String weCanMailUrl = 'http://dash.thesportk.com';
  static const String auth = '?api_token=cdxo3ts8WT2RbL8ovPjExCo20qnABdBZSYWO8YoEPqKMvHifLPhk1uUZWQq6&locale=en';

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
  static const String teamsBySeason = '/football/teams/seasons';
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
  static const String leagueSearch = '/football/leagues/search';
  static const String teamsSearch = '/football/teams/search';
  static const String playersSearch = '/football/players/search';
  static const String leagueByTeam = '/football/fixtures/between';

  ///weCan url
  static const String login = '/api/login';
  static const String intro = '/api/introductions';
  static const String news = '/api/blogs';
  static const String showLive = '/api/lives/match';
  static const String comments = '/api/comments';
  static const String newComments = '/api/blogs/comments';
  static const String user = '/api/users';
  static const String like = '/api/likes';
  static const String ourTeams = '/api/teams';
  static const String ourLeagues = '/api/competitions';
  static const String livesMatches = '/api/lives';
  static const String homeComp = '/api/competitions/home';
  static const String dislikeComment = '/api/likes/comments/destroy';
  static const String dislikeBlog = '/api/likes/blogs/destroy';
  static const String favorites = '/api/favorites/user';
  static const String removeFavorites = '/api/favorites';
  static const String vouchers = '/api/vouchers';
  static const String points = '/api/settings';
  static const String updateProfile = '/api/users/update';
  static const String policy = '/api/pages';
}
