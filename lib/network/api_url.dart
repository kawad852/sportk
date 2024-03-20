import 'package:sportk/utils/shared_pref.dart';

class ApiUrl {
  static const String sportsMailUrl = 'https://api.sportmonks.com/v3';
  static const String weCanMailUrl = 'http://dash.thesportk.com';
  static String locale = 'locale=${MySharedPreferences.language}';
  static String auth = '?api_token=cdxo3ts8WT2RbL8ovPjExCo20qnABdBZSYWO8YoEPqKMvHifLPhk1uUZWQq6';

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
  static const String leaguesByCountry = '/football/leagues/countries';

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
  static const String favoritesAdd = '/api/favorites';
  static const String removeFavorites = '/api/favorites';
  static const String vouchers = '/api/vouchers';
  static const String points = '/api/settings';
  static const String swapRequests = '/api/voucher/codes/user';
  static const String recordPoints = '/api/points/user';
  static const String updateProfile = '/api/users/update';
  static const String policy = '/api/pages';
  static const String voucherReplaced = '/api/voucher/codes';
  static const String faq = '/api/faqs';
  static const String deleteAccount = '/api/users/delete';
  static const String invitationCode = '/api/users/code';
  static const String notifications = '/api/notifications/user';
}
