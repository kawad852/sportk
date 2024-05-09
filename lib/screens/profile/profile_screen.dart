import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/providers/app_provider.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/contact/contact_screen.dart';
import 'package:sportk/screens/faq/faq_screen.dart';
import 'package:sportk/screens/language/language_screen.dart';
import 'package:sportk/screens/policy/policy_screen.dart';
import 'package:sportk/screens/profile/edit_profile_screen.dart';
import 'package:sportk/screens/profile/widgets/profile_header.dart';
import 'package:sportk/screens/profile/widgets/profile_tile.dart';
import 'package:sportk/screens/registration/registration_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/stretch_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AppProvider _appProvider;
  late AuthProvider _authProvider;

  void _toggleNotification() {
    setState(() {
      MySharedPreferences.notificationsEnabled = !MySharedPreferences.notificationsEnabled;
    });
    if (MySharedPreferences.notificationsEnabled) {
      FirebaseMessaging.instance.getToken();
    } else {
      FirebaseMessaging.instance.deleteToken();
    }
  }

  void _openStore(BuildContext context) async {
    try {
      const appId = 'com.eascore.wecan';
      final path = Platform.isAndroid ? 'market://details?id=$appId' : 'https://apps.apple.com/app/id$appId';
      final uri = Uri.parse(path);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      log("UrlLauncherError:: $e");
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _appProvider = context.appProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: kBarLeadingWith,
        leading: const CustomBack(),
        title: Text(context.appLocalization.menu),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Center(
              child: StretchedButton(
                child: Text(authProvider.isAuthenticated ? context.appLocalization.logout : context.appLocalization.guestLoginMsg),
                onPressed: () {
                  if (authProvider.isAuthenticated) {
                    authProvider.logout(context);
                  } else {
                    context.push(const RegistrationScreen(hideGuestButton: true));
                  }
                },
              ),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ProfileHeader(title: context.appLocalization.mySettings),
          StatefulBuilder(
            builder: (context, setState) {
              return ProfileTile(
                onTap: () {
                  _toggleNotification();
                },
                title: context.appLocalization.notifications,
                icon: MyIcons.bell,
                trailing: Switch(
                  value: MySharedPreferences.notificationsEnabled,
                  onChanged: (value) {
                    _toggleNotification();
                  },
                ),
              );
            },
          ),
          Selector<AppProvider, String>(
            selector: (context, provider) => provider.appTheme,
            builder: (context, appTheme, child) {
              return ProfileTile(
                onTap: () {
                  _appProvider.changeTheme(context, theme: appTheme == ThemeEnum.light ? ThemeEnum.dark : ThemeEnum.light);
                },
                title: context.appLocalization.nightMode,
                icon: MyIcons.moon,
                trailing: Switch(
                  value: appTheme == ThemeEnum.dark,
                  onChanged: (value) {
                    _appProvider.changeTheme(context, theme: appTheme == ThemeEnum.light ? ThemeEnum.dark : ThemeEnum.light);
                  },
                ),
              );
            },
          ),
          if (_authProvider.isAuthenticated) ...[
            ProfileTile(
              onTap: () {
                context.push(const EditProfileScreen());
              },
              title: context.appLocalization.profileSettings,
              icon: MyIcons.settings,
            ),
          ],
          ProfileTile(
            onTap: () {
              context.push(const LanguageScreen());
            },
            title: context.appLocalization.appLanguage,
            icon: MyIcons.language,
          ),
          ProfileHeader(title: context.appLocalization.application),
          ProfileTile(
            onTap: () {
              context.push(const PolicyScreen(id: 1));
            },
            title: context.appLocalization.termsOfUse,
            icon: MyIcons.clipBoard,
          ),
          ProfileTile(
            onTap: () {
              context.push(const PolicyScreen(id: 2));
            },
            title: context.appLocalization.privacyPolicy,
            icon: MyIcons.taskSquare,
          ),
          ProfileTile(
            onTap: () {
              context.push(const FAQScreen());
            },
            title: context.appLocalization.faq,
            icon: MyIcons.questions,
          ),
          ProfileTile(
            onTap: () {
              context.push(const ContactScreen());
            },
            title: context.appLocalization.contactUs,
            icon: MyIcons.messages,
          ),
          ProfileTile(
            onTap: () {
              _openStore(context);
            },
            title: context.appLocalization.rateApp,
            icon: MyIcons.starOutlined,
          ),
          ProfileTile(
            onTap: () {},
            title: context.appLocalization.shareApp,
            icon: MyIcons.starOutlined,
          ),
        ],
      ),
    );
  }
}
