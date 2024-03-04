import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/alerts/loading/app_over_loader.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/home/home_screen.dart';
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
        automaticallyImplyLeading: false,
        actions: [
          if (!widget.hideGuestButton)
            TextButton(
              onPressed: () {
                context.push(const HomeScreen());
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
            child: Image.asset(MyImages.coins),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    MyImages.apple,
                    width: 50,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
