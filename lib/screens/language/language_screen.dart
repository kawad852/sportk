import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/providers/app_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.appLanguage),
      ),
      body: Consumer<AppProvider>(
        builder: (context, appConfigProvider, child) {
          return Column(
            children: [
              RadioListTile<String>(
                value: LanguageEnum.english,
                groupValue: appConfigProvider.appLocale.languageCode,
                title: const Text("English"),
                onChanged: (value) {
                  appConfigProvider.changeLanguage(context, languageCode: value!);
                },
              ),
              RadioListTile<String>(
                value: LanguageEnum.arabic,
                groupValue: appConfigProvider.appLocale.languageCode,
                title: const Text("العربية"),
                onChanged: (value) {
                  appConfigProvider.changeLanguage(context, languageCode: value!);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
