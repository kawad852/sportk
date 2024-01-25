import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/model/locale_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/utils/shared_pref.dart';

class AuthProvider extends ChangeNotifier {
  var user = AuthModel();
  late Future<String> countryCodeFuture;

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  bool get isAuthenticated => user.id != null;

  void initUser() {
    user = AuthModel.copy(MySharedPreferences.user);
  }

  Future<void> updateUser(
    BuildContext context, {
    AuthModel? authModel,
    bool notify = true,
    bool updateDoc = true,
  }) async {
    user = AuthModel.copy(authModel ?? user);
    MySharedPreferences.saveUser(authModel ?? user);
    debugPrint("User:: ${user.toJson()}");
    if (notify) {
      notifyListeners();
    }
  }

  void logout(BuildContext context) {
    _firebaseAuth.signOut();
    updateUser(context, authModel: AuthModel(), updateDoc: false);
    // context.pushAndRemoveUntil(const RegistrationScreen());
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
}
