import 'package:flutter/foundation.dart';
import 'package:sportk/model/comments_model.dart';
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
}
