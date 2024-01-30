import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/screens/championships/widgets/championships_card.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/screens/championships/widgets/league_card.dart';

class ChampionshipsScreen extends StatefulWidget {
  const ChampionshipsScreen({super.key});

  @override
  State<ChampionshipsScreen> createState() => _ChampionshipsScreenState();
}

class _ChampionshipsScreenState extends State<ChampionshipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              onPressed: () {},
              icon: const CustomSvg(MyIcons.sort),
            ),
            title: Center(
              child: Text(
                context.appLocalization.championships,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const CustomSvg(MyIcons.search),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular ChampionshipsScreen",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return const LeagueCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.all(20),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ChampionshipsCard(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
