import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/providers/app_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _appProvider = context.appProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: kBarLeadingWith,
        leading: const CustomBack(),
        title: Text("Menu"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
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
        ],
      ),
    );
  }
}
