import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/stretch_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AppProvider _appProvider;
  late AuthProvider _authProvider;

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
      bottomSheet: BottomAppBar(
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
          if (_authProvider.isAuthenticated) ...[
            ProfileHeader(title: context.appLocalization.mySettings),
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
            ProfileTile(
              onTap: () {
                context.push(const EditProfileScreen());
              },
              title: context.appLocalization.profileSettings,
              icon: MyIcons.settings,
            ),
            ProfileTile(
              onTap: () {
                context.push(const LanguageScreen());
              },
              title: context.appLocalization.appLanguage,
              icon: MyIcons.language,
            ),
          ],
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
        ],
      ),
    );
  }
}
