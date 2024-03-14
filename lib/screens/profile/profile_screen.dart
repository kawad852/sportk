import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/providers/app_provider.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/contact/contact_screen.dart';
import 'package:sportk/screens/faq/faq_screen.dart';
import 'package:sportk/screens/policy/policy_screen.dart';
import 'package:sportk/screens/profile/widgets/profile_header.dart';
import 'package:sportk/screens/profile/widgets/profile_tile.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';

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
                    value: appTheme == ThemeEnum.light,
                    onChanged: (value) {
                      _appProvider.changeTheme(context, theme: appTheme == ThemeEnum.light ? ThemeEnum.dark : ThemeEnum.light);
                    },
                  ),
                );
              },
            ),
            ProfileTile(
              onTap: () {},
              title: context.appLocalization.profileSettings,
              icon: MyIcons.settings,
            ),
            ProfileTile(
              onTap: () {},
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
