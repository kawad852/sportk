import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportk/alerts/errors/app_error_feedback.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/model/locale_model.dart';
import 'package:sportk/model/user_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/screens/invitation_code/invitation_code_screen.dart';
import 'package:sportk/screens/registration/registration_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/shared_pref.dart';

class AuthProvider extends ChangeNotifier {
  var user = UserData();
  late Future<String> countryCodeFuture;
  String? _lastRouteName;
  bool _executeLastRouteCallback = false;
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  bool get isAuthenticated => user.id != null;

  void initUser() {
    user = UserData.copy(MySharedPreferences.user);
  }

  void _popUntilLastPage(BuildContext context) {
    _executeLastRouteCallback = true;
    Navigator.popUntil(context, (route) => route.settings.name == _lastRouteName);
  }

  Future login(
    BuildContext context, {
    required String? displayName,
    required String? email,
    required String? photoURL,
    bool withOverlayLoader = false,
  }) async {
    await ApiFutureBuilder<AuthModel>().fetch(
      context,
      withOverlayLoader: withOverlayLoader,
      future: () {
        final favoritesProvider = context.favoriteProvider;
        final socialLoginFuture = ApiService<AuthModel>().build(
          weCanUrl: ApiUrl.login,
          isPublic: true,
          apiType: ApiType.post,
          queryParams: {
            "name": displayName,
            "email": email,
            "profile_img": photoURL,
            "locale": MySharedPreferences.language,
            "favorites": favoritesProvider.favorites
                .map((e) => {
                      'favoritable_id': e.favoritableId,
                      'type': e.type,
                    })
                .toList(),
          },
          builder: AuthModel.fromJson,
        );
        return socialLoginFuture;
      },
      onComplete: (snapshot) async {
        if (snapshot.status == true) {
          await context.favoriteProvider.fetchFavs(context);
          MySharedPreferences.accessToken = snapshot.data!.token!;
          if (!context.mounted) return;
          updateUser(context, userModel: snapshot.data!.user);
          if (_lastRouteName == null) {
            if (snapshot.data!.user!.invitationCodeStatus == 0) {
              context.pushAndRemoveUntil(const InvitationCodeScreen());
            } else {
              context.pushAndRemoveUntil(const AppNavBar());
            }
          } else {
            _popUntilLastPage(context);
          }
        } else {
          context.showSnackBar(snapshot.msg!);
        }
      },
      onError: (failure) => AppErrorFeedback.show(context, failure),
    );
  }

  Future<void> updateUser(
    BuildContext context, {
    UserData? userModel,
    bool notify = true,
  }) async {
    user = UserData.copy(userModel ?? user);
    MySharedPreferences.saveUser(userModel ?? user);
    debugPrint("User:: ${user.toJson()}");
    if (notify) {
      notifyListeners();
    }
  }

  void logout(BuildContext context) {
    _firebaseAuth.signOut();
    MySharedPreferences.clearStorage();
    updateUser(context, userModel: UserData());
    context.favoriteProvider.favorites.clear();
    context.pushAndRemoveUntil(const RegistrationScreen());
  }

  void initializeLocale(BuildContext context) async {
    countryCodeFuture = ApiService<LocaleModel>()
        .build(
          sportsUrl: '',
          link: 'https://cloud.appwrite.io/v1/locale',
          apiType: ApiType.get,
          builder: LocaleModel.fromJson,
          isPublic: true,
        )
        .then((value) => value.countryCode!);
  }

  Future<AuthModel> updateProfile(
    BuildContext context,
    Map<String, dynamic> queryParams, {
    bool update = true,
  }) async {
    return ApiService<AuthModel>().build(
      weCanUrl: ApiUrl.updateProfile,
      isPublic: false,
      apiType: ApiType.post,
      builder: AuthModel.fromJson,
      queryParams: queryParams,
      onEnd: (snapshot) {
        if (update) {
          updateUser(context, userModel: snapshot.data!.user);
        }
      },
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    ApiFutureBuilder().fetch(
      context,
      future: () async {
        final updateProfileFuture = ApiService<AuthModel>().build(
          weCanUrl: '${ApiUrl.deleteAccount}/${user.id}',
          isPublic: false,
          apiType: ApiType.get,
          builder: AuthModel.fromJson,
        );
        return updateProfileFuture;
      },
      onComplete: (snapshot) {
        context.showSnackBar(context.appLocalization.accountDeletedMsg);
        logout(context);
      },
    );
  }

  Future<void> updateDeviceToken(BuildContext context) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('all');
      final deviceToken = await FirebaseMessaging.instance.getToken();
      debugPrint("DeviceToken:: $deviceToken");
      if (context.mounted && isAuthenticated) {
        ApiFutureBuilder().fetch(
          context,
          withOverlayLoader: false,
          future: () async {
            final updateProfileFuture = updateProfile(
              context,
              update: false,
              {'device_token': deviceToken},
            );
            return updateProfileFuture;
          },
          onError: null,
        );
      }
    } catch (e) {
      debugPrint("DeviceTokenError:: $e");
    }
  }

  Future<UserModel> getUserProfile(BuildContext context, int id) {
    final snapshot = ApiService<UserModel>().build(
        weCanUrl: '${ApiUrl.user}/$id',
        isPublic: false,
        apiType: ApiType.get,
        builder: UserModel.fromJson,
        onEnd: (snapshot) {
          updateUser(context, userModel: snapshot.data!);
        });
    return snapshot;
  }

  Future checkIfUserAuthenticated(
    BuildContext context, {
    required Function() callback,
  }) async {
    if (isAuthenticated) {
      callback();
    } else {
      debugPrint("RouteName::: ${context.currentRouteName}");
      context
          .showDialog(
        titleText: context.appLocalization.login,
        bodyText: context.appLocalization.loginToCont,
        confirmTitle: context.appLocalization.login,
      )
          .then((value) {
        if (value != null) {
          _lastRouteName = context.currentRouteName;
          context.push(const RegistrationScreen(hideGuestButton: true)).then((value) {
            _lastRouteName = null;
            if (_executeLastRouteCallback) {
              callback();
              _executeLastRouteCallback = false;
            }
          });
        }
      });
    }
  }
}
