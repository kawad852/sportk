import 'package:flutter/foundation.dart';
import 'package:sportk/model/comment_like_model.dart';
import 'package:sportk/model/comments_model.dart';
import 'package:sportk/model/is_like_model.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';

class CommonProvider extends ChangeNotifier {
  Future<NewModel> fetchNews(int pageKey) {
    final snapshot = ApiService<NewModel>().build(
      weCanUrl: '${ApiUrl.news}?page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: NewModel.fromJson,
    );
    return snapshot;
  }

  Future<CommentsModel> fetchComments(int id, int pageKey) {
    final snapshot = ApiService<CommentsModel>().build(
      weCanUrl: '${ApiUrl.newComments}/$id',
      isPublic: false,
      apiType: ApiType.get,
      builder: CommentsModel.fromJson,
    );
    return snapshot;
  }

  Future<CommentLikeModel> fetchCommentLikes(int id) {
    final snapshot = ApiService<CommentLikeModel>().build(
      weCanUrl: '${ApiUrl.commentLikes}/$id',
      isPublic: false,
      apiType: ApiType.get,
      builder: CommentLikeModel.fromJson,
    );
    return snapshot;
  }

  Future<IsLikeModel> fetchIsLike(int id) {
    final snapshot = ApiService<IsLikeModel>().build(
      weCanUrl: '${ApiUrl.isLike}/$id',
      isPublic: false,
      apiType: ApiType.get,
      builder: IsLikeModel.fromJson,
    );
    return snapshot;
  }

  Future<IsLikeModel> like(int id) {
    final snapshot = ApiService<IsLikeModel>().build(
      weCanUrl: ApiUrl.like,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {
        'comment_id': id,
      },
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
