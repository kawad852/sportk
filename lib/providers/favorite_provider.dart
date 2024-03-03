import 'package:flutter/material.dart';
import 'package:sportk/alerts/errors/app_error_feedback.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/main.dart';
import 'package:sportk/model/favorite_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/base_extensions.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteData> favorites = [];
  Future<FavoriteModel>? favFuture;

  bool isFav(int id, String type) {
    final favs = favorites.where((element) => element.type == type).toList();
    final ids = favs.map((e) => e.favoritableId).toList();
    final inFav = ids.contains(id);
    return inFav;
  }

  Future<bool> toggleFavorites(int id, String type, String name) async {
    final favs = favorites.where((element) => element.type == type).toList();
    final ids = favs.map((e) => e.favoritableId).toList();
    if (ids.contains(id)) {
      final result = await _showDialog(navigatorKey.currentState!.context, name);
      if (result != null) {
        final favId = favorites.firstWhere((element) => element.type == type && element.favoritableId == id).id!;
        removeFromFav(id: favId);
        favorites.removeWhere((element) => element.type == type && element.favoritableId == id);
        notifyListeners();
        return true;
      }
    } else {
      favorites.add(FavoriteData(
        favoritableId: id,
        type: type,
      ));
    }
    notifyListeners();
    return false;
  }

  void fetchFavs(BuildContext context) {
    if (favFuture != null) return;
    final authProvider = context.authProvider;
    if (authProvider.isAuthenticated) {
      favFuture = ApiService<FavoriteModel>()
          .build(
        weCanUrl: ApiUrl.favorites,
        isPublic: false,
        apiType: ApiType.get,
        builder: FavoriteModel.fromJson,
      )
          .then((value) {
        favorites = value.data!;
        return value;
      });
    } else {
      favFuture = Future.value(FavoriteModel(
        code: 200,
        data: [],
      ));
    }
  }

  Future<dynamic> _showDialog(BuildContext context, String name) {
    return context
        .showDialog(
          titleText: '',
          bodyText: context.appLocalization.favRemoveMsg(name),
        )
        .then((value) => value);
  }

  Future removeFromFav({
    required int id,
  }) async {
    final ctx = navigatorKey.currentState!.context;
    await ApiFutureBuilder<FavoriteModel>().fetch(
      ctx,
      withOverlayLoader: false,
      future: () {
        final socialLoginFuture = ApiService<FavoriteModel>().build(
          weCanUrl: '${ApiUrl.removeFavorites}/$id',
          isPublic: false,
          apiType: ApiType.get,
          builder: FavoriteModel.fromJson,
        );
        return socialLoginFuture;
      },
      onComplete: (snapshot) {},
      onError: (failure) => AppErrorFeedback.show(ctx, failure),
    );
  }
}
