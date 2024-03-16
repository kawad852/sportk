import 'package:flutter/material.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/editors/email_editor.dart';
import 'package:sportk/widgets/editors/text_editor.dart';
import 'package:sportk/widgets/stretch_button.dart';
import 'package:sportk/widgets/titled_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserData _user;
  late AuthProvider _authProvider;
  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      ApiFutureBuilder().fetch(
        context,
        future: () async {
          final updateProfileFuture = _authProvider.updateProfile(
            context,
            {
              'name': _user.name,
            },
          );
          return updateProfileFuture;
        },
        onComplete: (snapshot) {
          context.showSnackBar(context.appLocalization.updateSuccessfully);
        },
      );
    }
  }

  void _showDeleteAccDialog(BuildContext context) {
    context
        .showDialog(
      titleText: context.appLocalization.deleteAccount,
      bodyText: context.appLocalization.deleteAccountMsg,
      warning: true,
    )
        .then((value) {
      if (value != null) {
        _authProvider.deleteAccount(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _user = UserData.copy(_authProvider.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.profileSettings),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: StretchedButton(
            child: Text(context.appLocalization.save),
            onPressed: () {
              _submit(context);
            },
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ListBody(
                children: [
                  TitledTextField(
                    title: context.appLocalization.name,
                    child: TextEditor(
                      initialValue: _user.name,
                      onChanged: (value) => _user.name = value,
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.email,
                    child: EmailEditor(
                      initialValue: _user.email,
                      onChanged: (value) {},
                      readonly: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      onPressed: () {
                        _showDeleteAccDialog(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: context.colorScheme.error,
                      ),
                      icon: const Icon(Icons.delete),
                      label: Text(
                        context.appLocalization.deleteAccount,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
