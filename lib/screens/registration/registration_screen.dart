import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/alerts/loading/app_over_loader.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/widgets/title/medium_title.dart';

class RegistrationScreen extends StatefulWidget {
  final bool hideGuestButton;
  const RegistrationScreen({
    super.key,
    this.hideGuestButton = false,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late AuthProvider _authProvider;

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken == null) {
        AppOverlayLoader.hide();
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final auth = await _firebaseAuth.signInWithCredential(credential);
      if (context.mounted) {
        await _authProvider.login(
          context,
          displayName: auth.user?.displayName,
          email: auth.user?.email,
          photoURL: auth.user?.photoURL,
        );
      }
    } on PlatformException catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        if (e.code == GoogleSignIn.kNetworkError) {
          context.showSnackBar(context.appLocalization.networkError);
        } else {
          if (context.mounted) {
            context.showSnackBar(context.appLocalization.generalError);
          }
        }
      }
      debugPrint("GoogleSignInException:: $e");
    } catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
      debugPrint("GoogleSignInException:: $e");
    } finally {
      AppOverlayLoader.hide();
    }
  }

  Future<void> _fbLogin(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    try {
      // AppOverlayLoader.show();
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );
      print("status:::: ${result.message}");
      if (result.status == LoginStatus.success) {
        AppOverlayLoader.hide();
        if (result.accessToken == null) {
          throw '';
        }
        final userData = await FacebookAuth.instance.getUserData();
        var email = userData['email'];
        var displayName = userData['name'];
        var photoURL = userData['picture']['data']['url'];
        if (context.mounted) {
          await _authProvider.login(
            context,
            displayName: displayName,
            email: email,
            photoURL: photoURL,
            withOverlayLoader: true,
          );
        }
      } else {
        AppOverlayLoader.hide();
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
    } catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        print("eeeee:::: $e");
        context.showSnackBar(context.appLocalization.generalError);
      }
    } finally {
      AppOverlayLoader.hide();
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      // AppOverlayLoader.show();
      final LoginResult loginResult = await FacebookAuth.instance.login();

      print("accessToken ${loginResult.message}");

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      if (facebookAuthCredential.accessToken == null) {
        AppOverlayLoader.hide();
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: facebookAuthCredential.accessToken,
        idToken: facebookAuthCredential.idToken,
      );

      final auth = await _firebaseAuth.signInWithCredential(credential);
      if (context.mounted) {
        await _authProvider.login(
          context,
          displayName: auth.user?.displayName,
          email: auth.user?.email,
          photoURL: auth.user?.photoURL,
          withOverlayLoader: true,
        );
      }
    } on PlatformException catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        if (e.code == GoogleSignIn.kNetworkError) {
          context.showSnackBar(context.appLocalization.networkError);
        } else {
          if (context.mounted) {
            context.showSnackBar(context.appLocalization.generalError);
          }
        }
      }
      debugPrint("FacebookSignInException:: $e");
    } catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
      debugPrint("FacebookSignInException:: $e");
    } finally {
      AppOverlayLoader.hide();
    }
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final auth = await _firebaseAuth.signInWithCredential(oauthCredential);
      if (context.mounted) {
        await _authProvider.login(
          context,
          displayName: auth.user?.displayName,
          email: auth.user?.email,
          photoURL: auth.user?.photoURL,
        );
      }
    } on PlatformException catch (e) {
      AppOverlayLoader.hide();
      if (e.code == GoogleSignIn.kNetworkError && context.mounted) {
        context.showSnackBar(context.appLocalization.networkError, duration: 8);
      } else {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
      debugPrint("AppleSignInException:: $e");
    } catch (e) {
      AppOverlayLoader.hide();
      debugPrint("AppleSignInException:: $e");
    } finally {
      AppOverlayLoader.hide();
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: widget.hideGuestButton,
        actions: [
          if (!widget.hideGuestButton)
            TextButton(
              onPressed: () {
                context.push(const AppNavBar());
              },
              child: Text(
                context.appLocalization.skip,
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MediumTitle(context.appLocalization.registrationTitle),
          const SizedBox(height: 10),
          Text(context.appLocalization.registrationBody),
          Padding(
            padding: const EdgeInsets.only(top: 70, bottom: 70),
            child: Image.asset(Platform.isIOS ? MyImages.coins2 : MyImages.coins),
          ),
          Text(
            context.appLocalization.registerWith,
            textAlign: TextAlign.center,
            style: context.textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _signInWithGoogle(context);
                },
                child: Image.asset(
                  MyImages.google,
                  width: 50,
                ),
              ),
              if (Platform.isIOS)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      _signInWithApple(context);
                    },
                    child: Image.asset(
                      MyImages.apple,
                      width: 50,
                    ),
                  ),
                )
              else
                const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  _fbLogin(context);
                  // _signInWithFacebook(context);
                },
                child: Image.asset(
                  MyImages.facebook,
                  width: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
