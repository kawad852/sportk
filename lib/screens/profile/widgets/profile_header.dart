import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class ProfileHeader extends StatelessWidget {
  final String title;

  const ProfileHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
