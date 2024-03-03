import 'package:flutter/foundation.dart';
import 'package:sportk/model/favorite_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> favorites = [];

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
      favorites.add(FavoriteModel(
        favoritableId: id,
        type: type,
      ));
    }
    notifyListeners();
  }
}
