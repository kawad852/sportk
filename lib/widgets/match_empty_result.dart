import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/no_results.dart';

class MatchEmptyResult extends StatelessWidget {
  const MatchEmptyResult({super.key});

  @override
  Widget build(BuildContext context) {
    return NoResults(
      header: const Icon(FontAwesomeIcons.trophy),
      title: context.appLocalization.noMatchesAtTheMoment,
    );
  }
}
