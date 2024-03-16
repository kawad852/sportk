import 'package:flutter/material.dart';
import 'package:sportk/alerts/errors/app_error_feedback.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/main.dart';
import 'package:sportk/model/add_favorite_model.dart';
import 'package:sportk/model/favorite_model.dart';
import 'package:sportk/model/matches/our_league_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/base_extensions.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteData> favorites = [];
  late Future<FavoriteModel> favFuture;

  bool isFav(int id, String type) {
    final favs = favorites.where((element) => element.type == type).toList();
    final ids = favs.map((e) => e.favoritableId).toList();
    final inFav = ids.contains(id);
    return inFav;
  }

  Future toggleFavorites(
    BuildContext context,
    int id,
    String type,
    String? name, {
    bool showDialog = true,
  }) async {
    final isAuthenticated = context.authProvider.isAuthenticated;
    final favs = favorites.where((element) => element.type == type).toList();
    final ids = favs.map((e) => e.favoritableId).toList();
    if (ids.contains(id)) {
      if (showDialog && name != null) {
        final result = await _showDialog(navigatorKey.currentState!.context, name);
        if (result != null) {
          final favId = favorites.firstWhere((element) => element.type == type && element.favoritableId == id).id!;
          removeFromFav(id: favId);
          favorites.removeWhere((element) => element.type == type && element.favoritableId == id);
          notifyListeners();
          return true;
        }
      } else {
        if (isAuthenticated) {
          final favId = favorites.firstWhere((element) => element.type == type && element.favoritableId == id).id!;
          removeFromFav(id: favId);
        }
        favorites.removeWhere((element) => element.type == type && element.favoritableId == id);
        notifyListeners();
        return true;
      }
    } else {
      if (isAuthenticated) {
        await addToFavorite(context, id: id, type: type);
      } else {
        favorites.add(FavoriteData(
          favoritableId: id,
          type: type,
        ));
      }
      notifyListeners();
    }
  }

  Future<FavoriteModel> fetchFavs(BuildContext context) async {
    // if (favFuture != null) return null;
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
        favorites.addAll(value.data!);
        return value;
      });
    } else {
      favFuture = Future.value(FavoriteModel(
        code: 200,
        data: [],
      ));
      final data = await favFuture;
      favorites = data.data!;
    }
    return favFuture;
  }

  Future<dynamic> _showDialog(BuildContext context, String name) {
    return context
        .showDialog(
          titleText: '',
          bodyText: context.appLocalization.favRemoveMsg(name),
        )
        .then((value) => value);
  }

  Future addToFavorite(
    BuildContext context, {
    required int id,
    required String type,
  }) async {
    await ApiFutureBuilder<AddFavoriteModel>().fetch(
      context,
      future: () {
        final favoritesFuture = ApiService<AddFavoriteModel>().build(
          weCanUrl: ApiUrl.favoritesAdd,
          isPublic: false,
          apiType: ApiType.post,
          builder: AddFavoriteModel.fromJson,
          queryParams: {
            'favoritable_id': id.toString(),
            'type': type,
          },
        );
        return favoritesFuture;
      },
      onComplete: (snapshot) {
        if (snapshot.code == 200) {
          favorites.add(FavoriteData(
            id: snapshot.data!.id,
            favoritableId: id,
            type: type,
          ));
        } else {
          context.showSnackBar(context.appLocalization.generalError);
        }
      },
      onError: (failure) => AppErrorFeedback.show(context, failure),
    );
  }

  Future removeFromFav({
    required int id,
  }) async {
    final ctx = navigatorKey.currentState!.context;
    if (!ctx.authProvider.isAuthenticated) return;
    await ApiFutureBuilder<OurLeaguesModel>().fetch(
      ctx,
      withOverlayLoader: false,
      future: () {
        final socialLoginFuture = ApiService<OurLeaguesModel>().build(
          weCanUrl: '${ApiUrl.removeFavorites}/$id',
          isPublic: false,
          apiType: ApiType.get,
          builder: OurLeaguesModel.fromJson,
        );
        return socialLoginFuture;
      },
      onComplete: (snapshot) {},
      onError: (failure) => AppErrorFeedback.show(ctx, failure),
    );
  }
}
