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
import 'package:sportk/screens/registration/registration_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/shared_pref.dart';

class AuthProvider extends ChangeNotifier {
  var user = UserData();
  late Future<String> countryCodeFuture;

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  bool get isAuthenticated => user.id != null;

  void initUser() {
    user = UserData.copy(MySharedPreferences.user);
  }

  Future login(
    BuildContext context, {
    required String? displayName,
    required String? email,
    required List<int> selectedTeams,
    required List<int> selectedLeagues,
  }) async {
    final teams = selectedTeams.map((e) {
      return {
        'type': CompoTypeEnum.teams,
        'favoritable_id': e,
      };
    }).toList();
    final leagues = selectedTeams.map((e) {
      return {
        'type': CompoTypeEnum.competitions,
        'favoritable_id': e,
      };
    }).toList();
    await ApiFutureBuilder<AuthModel>().fetch(
      context,
      withOverlayLoader: false,
      future: () {
        final socialLoginFuture = ApiService<AuthModel>().build(
          weCanUrl: ApiUrl.login,
          isPublic: true,
          apiType: ApiType.post,
          queryParams: {
            "name": displayName,
            "email": email,
            "favorites": [...teams, ...leagues],
          },
          builder: AuthModel.fromJson,
        );
        return socialLoginFuture;
      },
      onComplete: (snapshot) {
        if (snapshot.status == true) {
          context.pushAndRemoveUntil(const AppNavBar());
          MySharedPreferences.accessToken = snapshot.data!.token!;
          updateUser(context, userModel: snapshot.data!.user);
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

  Future<void> updateDeviceToken(BuildContext context) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('all');
      final deviceToken = await FirebaseMessaging.instance.getToken();
      debugPrint("DeviceToken:: $deviceToken");
      if (context.mounted) {
        // ApiService<UpdateProfileModel>().fetch(
        //   context,
        //   withOverlayLoader: false,
        //   url: ApiUrl.deviceToken,
        //   isPublic: true,
        //   apiType: ApiType.get,
        //   builder: UpdateProfileModel.fromJson,
        //   onError: null,
        // );
      }
    } catch (e) {
      debugPrint("DeviceTokenError:: $e");
    }
  }

  Future<UserModel> getUserProfile(int id) {
    final snapshot = ApiService<UserModel>().build(
      weCanUrl: '${ApiUrl.user}/$id',
      isPublic: false,
      apiType: ApiType.get,
      builder: UserModel.fromJson,
    );
    return snapshot;
  }
}
