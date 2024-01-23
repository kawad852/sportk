import 'package:flutter/material.dart';
import 'package:scroll_indicator/scroll_indicator.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/card_news.dart';
import 'package:sportk/widgets/news_champ_card.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/latest_news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 0;
  final ScrollController _pageController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leadingWidth: 120,
              pinned: true,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      )),
                  const Text(
                    "رجوع",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: CustomSvg(
                      MyIcons.location,
                    ),
                  ),
                  Text(
                    "اخبار تهمك",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 131,
                    height: 35,
                    margin: const EdgeInsetsDirectional.only(start: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.colorPalette.red000,
                    ),
                    child: Text(
                      "اخبار جديدة",
                      style: TextStyle(color: context.colorPalette.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 257.0,
                child: ListView.builder(
                  controller: _pageController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const CardNews();
                  },
                ),
              ),
            ),
            //here
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ScrollIndicator(
                    scrollController: _pageController,
                    width: 100,
                    height: 10,
                    indicatorWidth: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colorPalette.grey3F,
                    ),
                    indicatorDecoration: BoxDecoration(
                      color: context.colorPalette.blueD4B,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.only(
                top: 20,
                start: 20,
                bottom: 5,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اخبار البطولات",
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return const NewsChampCard();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            //here

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15,
                  start: 20,
                  bottom: 5,
                ),
                child: Text(
                  "احدث الاخبار",
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.all(20),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  return const LatestNews();
                },
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: 6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
