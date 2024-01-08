import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/widgets/title/medium_title.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {},
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
              Image.asset(
                MyImages.google,
                width: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  MyImages.apple,
                  width: 60,
                ),
              ),
              Image.asset(
                MyImages.facebook,
                width: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
