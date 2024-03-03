import 'package:flutter/material.dart';
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

  void toggleFavorites(int id, String type) {
    final favs = favorites.where((element) => element.type == type).toList();
    final ids = favs.map((e) => e.favoritableId).toList();
    if (ids.contains(id)) {
      favorites.removeWhere((element) => element.type == type && element.favoritableId == id);
    } else {
      favorites.add(FavoriteData(
        favoritableId: id,
        type: type,
      ));
    }
    notifyListeners();
  }

  void fetchFavs(BuildContext context) {
    if (favFuture != null) return;
    final authProvider = context.authProvider;
    if (authProvider.isAuthenticated) {
      favFuture = ApiService<FavoriteModel>().build(
        weCanUrl: ApiUrl.favorites,
        isPublic: false,
        apiType: ApiType.get,
        builder: FavoriteModel.fromJson,
      );
    } else {
      favFuture = Future.value(FavoriteModel(
        code: 200,
        data: [],
      ));
    }
  }
}
