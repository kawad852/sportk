import 'package:flutter/foundation.dart';
import 'package:sportk/model/comments_model.dart';
import 'package:sportk/model/is_like_model.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/enums.dart';

class CommonProvider extends ChangeNotifier {
  Future<NewModel> fetchNews(
    int pageKey,
    String type,
  ) {
    final snapshot = ApiService<NewModel>().build(
      weCanUrl: type != BlogsType.mostRecent ? '${ApiUrl.news}/$type?page=$pageKey' : '${ApiUrl.news}?page=$pageKey',
      isPublic: type != BlogsType.recommended,
      apiType: ApiType.get,
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
    int id, {
    required bool isComment,
  }) {
    Map<String, dynamic> queryParams = {};
    if (isComment) {
      queryParams['comment_id'] = id;
    } else {
      queryParams['blog_id'] = id;
    }
    final snapshot = ApiService<IsLikeModel>().build(
      weCanUrl: ApiUrl.like,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: queryParams,
      builder: IsLikeModel.fromJson,
    );
    return snapshot;
  }

  Future<IsLikeModel> disLike(int id) {
    final snapshot = ApiService<IsLikeModel>().build(
      weCanUrl: '${ApiUrl.like}/$id',
      isPublic: false,
      apiType: ApiType.get,
      builder: IsLikeModel.fromJson,
    );
    return snapshot;
  }
}
