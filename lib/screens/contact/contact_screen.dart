import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/alerts/loading/app_over_loader.dart';
import 'package:sportk/helper/validation_helper.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/base_editor.dart';
import 'package:sportk/widgets/stretch_button.dart';
import 'package:sportk/widgets/titled_textfield.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController nameCtrl, subjectCtrl, msgCtrl, emailCtrl;
  final _formKey = GlobalKey<FormState>();
  late String dialCode;
  late AuthProvider authProvider;

  Future<void> _sendEmail(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      const url = 'https://api.emailjs.com/api/v1.0/email/send';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'origin': 'http://localhost',
      };
      var body = jsonEncode({
        'service_id': EmailJsEnum.serviceId,
        'template_id': EmailJsEnum.templateId,
        'user_id': EmailJsEnum.userId,
        'template_params': {
          'user_name': nameCtrl.text,
          'user_email': emailCtrl.text,
          'user_subject': subjectCtrl.text,
          'user_message': msgCtrl.text,
        },
      });
      debugPrint("Response:: CheckoutResponse\nUrl:: $url\nheaders:: ${headers.toString()}");
      http.Response response = await http.post(uri, headers: headers, body: body);
      debugPrint("CheckoutStatusCode:: ${response.statusCode} CheckoutBody:: ${response.body}");
      AppOverlayLoader.hide();
      if (response.statusCode == 200) {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.msgSendSuccessfully);
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
    } catch (e) {
      debugPrint("$e");
      AppOverlayLoader.hide();
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    nameCtrl = TextEditingController(text: authProvider.user.name);
    subjectCtrl = TextEditingController();
    msgCtrl = TextEditingController();
    emailCtrl = TextEditingController(text: authProvider.user.email);
    // dialCode = authProvider.user.code ?? '+962';
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    subjectCtrl.dispose();
    msgCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.contactUs),
      ),
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus();
              _sendEmail(context);
            }
          },
          child: Text(context.appLocalization.send),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Text(
              context.appLocalization.contactHeader,
              style: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TitledTextField(
              title: context.appLocalization.subject,
              child: BaseEditor(
                controller: subjectCtrl,
                validator: (value) {
                  return ValidationHelper.general(context, value);
                },
              ),
            ),
            TitledTextField(
              title: context.appLocalization.name,
              child: BaseEditor(
                controller: nameCtrl,
                validator: (value) {
                  return ValidationHelper.general(context, value);
                },
              ),
            ),
            TitledTextField(
              title: context.appLocalization.email,
              child: BaseEditor(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return ValidationHelper.email(context, value);
                },
              ),
            ),
            TitledTextField(
              title: context.appLocalization.message,
              child: BaseEditor(
                controller: msgCtrl,
                maxLines: 3,
                validator: (value) {
                  return ValidationHelper.general(context, value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
