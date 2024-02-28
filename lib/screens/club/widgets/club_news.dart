import 'package:flutter/material.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/screens/news/widgets/news_card.dart';

class ClubNews extends StatefulWidget {
  const ClubNews({super.key});

  @override
  State<ClubNews> createState() => _ClubNewsState();
}

class _ClubNewsState extends State<ClubNews> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return NewsCard(
            newData: NewData(),
          );
        },
      ),
    );
  }
}
