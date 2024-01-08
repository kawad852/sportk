import 'package:flutter/material.dart';
import 'package:sportk/screens/wizard/league_screen.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_bubble.dart';
import 'package:sportk/widgets/search_field.dart';
import 'package:sportk/widgets/stretch_button.dart';

class FollowTeamsScreen extends StatefulWidget {
  const FollowTeamsScreen({super.key});

  @override
  State<FollowTeamsScreen> createState() => _FollowTeamsScreenState();
}

class _FollowTeamsScreenState extends State<FollowTeamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.followYourTeam),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(context.appLocalization.skip),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: StretchedButton(
            onPressed: () {},
            child: Text(context.appLocalization.next),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 165,
              child: ListView.separated(
                itemCount: 15,
                padding: const EdgeInsets.all(20),
                separatorBuilder: (context, index) => const SizedBox(width: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const LeagueBubble();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchTextField(
                onChanged: (value) {},
                hintText: context.appLocalization.clubSearchHint,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList.separated(
              itemCount: 20,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.push(const LeagueScreen());
                  },
                  tileColor: context.colorPalette.grey2F2,
                  leading: const CustomNetworkImage(
                    kFakeImage,
                    radius: 0,
                    width: 25,
                    height: 25,
                  ),
                  title: const Text(
                    "English League",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const CustomSvg(MyIcons.starFilled),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
