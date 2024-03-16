import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/comments_model.dart';
import 'package:sportk/model/home_competitions_model.dart';
import 'package:sportk/model/invitation_code_model.dart';
import 'package:sportk/model/is_like_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/model/points_model.dart';
import 'package:sportk/model/record_points_model.dart';
import 'package:sportk/model/swap_requests_model.dart';
import 'package:sportk/model/vouchers_model.dart';
import 'package:sportk/model/vouchers_replaced_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/favorite_provider.dart';

class CommonProvider extends ChangeNotifier {
  late Future<HomeCompetitionsModel> leaguesFuture;
  late Future<LivesMatchesModel> liveMatchesFuture;
  late Future<List<dynamic>> leaguesAndLivesFutures;

  Future<HomeCompetitionsModel> fetchLeagues(int pageKey) {
    final snapshot = ApiService<HomeCompetitionsModel>().build(
      weCanUrl: '${ApiUrl.homeComp}?page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: HomeCompetitionsModel.fromJson,
    );
    return snapshot;
  }

  void fetchLives() {
    liveMatchesFuture = ApiService<LivesMatchesModel>().build(
      weCanUrl: ApiUrl.livesMatches,
      isPublic: true,
      apiType: ApiType.get,
      builder: LivesMatchesModel.fromJson,
    );
  }

  void initializeHome(BuildContext context) {
    final favoritesProvider = context.read<FavoriteProvider>();
    fetchLives();
    favoritesProvider.fetchFavs(context);
    leaguesAndLivesFutures = Future.wait([favoritesProvider.favFuture, liveMatchesFuture]);
  }

  Future<NewModel> fetchNews(
    int pageKey, {
    required String url,
  }) {
    final snapshot = ApiService<NewModel>().build(
      weCanUrl: '$url&page=$pageKey',
      isPublic: false,
      apiType: ApiType.get,
      additionalHeaders: {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': '*/*',
        // 'Content-Type': 'application/json',
      },
      builder: NewModel.fromJson,
    );
    return snapshot;
  }

  Future<CommentsModel> fetchComments(int id, int pageKey) {
    final snapshot = ApiService<CommentsModel>().build(
      weCanUrl: '${ApiUrl.newComments}/$id?page=$pageKey',
      isPublic: false,
      apiType: ApiType.get,
      builder: CommentsModel.fromJson,
    );
    return snapshot;
  }

  Future<IsLikeModel> like(
    int id,
    bool isLike, {
    required bool isComment,
  }) {
    Map<String, dynamic> queryParams = {};
    if (isComment) {
      queryParams['comment_id'] = id;
    } else {
      queryParams['blog_id'] = id;
    }
    queryParams['type'] = isLike ? 1 : 0;

    final snapshot = ApiService<IsLikeModel>().build(
      weCanUrl: ApiUrl.like,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: queryParams,
      builder: IsLikeModel.fromJson,
    );
    return snapshot;
  }

  Future<IsLikeModel> removeLike(int id, bool isComment) {
    final snapshot = ApiService<IsLikeModel>().build(
      weCanUrl: isComment ? '${ApiUrl.dislikeComment}/$id' : '${ApiUrl.dislikeBlog}/$id',
      isPublic: false,
      apiType: ApiType.get,
      builder: IsLikeModel.fromJson,
    );
    return snapshot;
  }

  Future<VouchersModel> getVouchers(int pageKey) {
    final snapshot = ApiService<VouchersModel>().build(
      weCanUrl: "${ApiUrl.vouchers}?page=$pageKey",
      isPublic: false,
      apiType: ApiType.get,
      builder: VouchersModel.fromJson,
    );
    return snapshot;
  }

  Future<PointsModel> getPoints() {
    final snapshot = ApiService<PointsModel>().build(
      weCanUrl: ApiUrl.points,
      isPublic: false,
      apiType: ApiType.get,
      builder: PointsModel.fromJson,
    );
    return snapshot;
  }

  Future<SwapRequestsModel> getSwapRequests(int pageKey) {
    final snapshot = ApiService<SwapRequestsModel>().build(
      weCanUrl: "${ApiUrl.swapRequests}?page=$pageKey",
      isPublic: false,
      apiType: ApiType.get,
      builder: SwapRequestsModel.fromJson,
    );
    return snapshot;
  }

  Future<RecordPointsModel> getRecordPoints(int pageKey) {
    final snapshot = ApiService<RecordPointsModel>().build(
      weCanUrl: "${ApiUrl.recordPoints}?page=$pageKey",
      isPublic: false,
      apiType: ApiType.get,
      builder: RecordPointsModel.fromJson,
    );
    return snapshot;
  }

  Future<VoucherReplacedModel> replacedVoucher(int voucherId) {
    final snapshot = ApiService<VoucherReplacedModel>().build(
      weCanUrl: ApiUrl.voucherReplaced,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {"voucher_id": voucherId},
      builder: VoucherReplacedModel.fromJson,
    );
    return snapshot;
  }

  Future<InvitationCodeModel> verifyInvitationCode(String code) {
    final snapshot = ApiService<InvitationCodeModel>().build(
      weCanUrl: "${ApiUrl.invitationCode}/$code",
      isPublic: false,
      apiType: ApiType.get,
      builder: InvitationCodeModel.fromJson,
    );
    return snapshot;
  }
}
