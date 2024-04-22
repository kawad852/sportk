import 'package:flutter/material.dart';
import 'package:sportk/screens/match_info/widgets/team_card_loading.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class MatchInfoLoading extends StatelessWidget {
  const MatchInfoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ShimmerLoading(
          child: LoadingBubble(
            width: double.infinity,
            height: context.systemButtonHeight + 4,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            leadingWidth: kBarLeadingWith,
            collapsedHeight: kBarCollapsedHeight,
            pinned: true,
            leading: CustomBack(
              color: context.colorPalette.white,
            ),
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MyTheme.isLightTheme(context)
                        ? MyImages.backgroundClub
                        : MyImages.backgroundClubDark,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ShimmerLoading(
                              child: LoadingBubble(
                                width: 70,
                                height: 70,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: 5),
                            ShimmerLoading(
                              child: LoadingBubble(
                                height: 20,
                                width: 60,
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 5, horizontal: 5),
                              ),
                            ),
                            SizedBox(height: 20),
                            ShimmerLoading(child: TeamCardLoading()),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ShimmerLoading(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingBubble(
                                width: 50,
                                height: 30,
                                margin: EdgeInsetsDirectional.symmetric(
                                    horizontal: 20),
                                radius: MyTheme.radiusSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ShimmerLoading(
                              child: LoadingBubble(
                                width: 70,
                                height: 70,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: 5),
                            ShimmerLoading(
                              child: LoadingBubble(
                                height: 20,
                                width: 60,
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 5, horizontal: 5),
                              ),
                            ),
                            SizedBox(height: 20),
                            ShimmerLoading(child: TeamCardLoading()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ShimmerLoading(
                    child: LoadingBubble(
                      height: 45,
                      width: double.infinity,
                      margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                      radius: MyTheme.radiusSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(
                color: context.colorPalette.blueD4B,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
