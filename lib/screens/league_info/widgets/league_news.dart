import 'package:flutter/material.dart';
import 'package:sportk/widgets/news_card.dart';

class LeagueNews extends StatelessWidget {
  const LeagueNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return const NewsCard(
              isMessage: true,
            );
          },
        ),
      ),
    );
  }
}