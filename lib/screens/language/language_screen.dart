import 'package:flutter/material.dart';
import 'package:sportk/providers/app_provider.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/stretch_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late AppProvider _appProvider;
  late String _selectedLanguage;

  void _submit(BuildContext context) {
    _appProvider.changeLanguage(context, languageCode: _selectedLanguage);
    context.pushAndRemoveUntil(const AppNavBar());
  }

  @override
  void initState() {
    super.initState();
    _appProvider = context.appProvider;
    _selectedLanguage = _appProvider.appLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.appLanguage),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: StretchedButton(
            onPressed: () {
              _submit(context);
            },
            child: Text(context.appLocalization.save),
          ),
        ),
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            value: LanguageEnum.english,
            groupValue: _selectedLanguage,
            title: const Text("English"),
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          RadioListTile<String>(
            value: LanguageEnum.arabic,
            groupValue: _selectedLanguage,
            title: const Text("العربية"),
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
