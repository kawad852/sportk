import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_smoth_indicator.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/news_card.dart';
import 'package:sportk/widgets/news_champ_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 0;

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
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: 10,
                    options: CarouselOptions(
                        reverse: false,
                        autoPlay: false,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: false,
                        height: 280.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                    itemBuilder: (context, index, realIndex) {
                      return const NewsCard();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSmoothIndicator(
                    count: 10,
                    index: currentIndex,
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
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.only(
                top: 15,
                start: 20,
                bottom: 5,
              ),
              sliver: SliverToBoxAdapter(
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
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const NewsCard(
                    isMessage: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
