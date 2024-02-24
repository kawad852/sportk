import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/widgets/news_champ_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_smoth_indicator.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/news_card.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 0;
  late CommonProvider _commonProvider;
  late Future<NewModel> _recommendedNewsFuture;
  late Future<NewModel> _compoNewsFuture;
  late Future<NewModel> _mostRecentNewsFuture;

  void _initializeRecommendedNews() {
    _recommendedNewsFuture = _commonProvider.fetchNews();
  }

  void _initializeCompoNews() {
    _compoNewsFuture = _commonProvider.fetchNews();
  }

  void _initializeRecentNews() {
    _mostRecentNewsFuture = _commonProvider.fetchNews();
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _initializeRecommendedNews();
    _initializeRecentNews();
    _initializeCompoNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
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
                  CustomFutureBuilder(
                    future: _recommendedNewsFuture,
                    onRetry: () {
                      setState(() {
                        _initializeRecommendedNews();
                      });
                    },
                    onLoading: () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            child: CarouselSlider.builder(
                              itemCount: 10,
                              options: CarouselOptions(
                                viewportFraction: 0.9,
                                enableInfiniteScroll: false,
                                height: 280.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                              itemBuilder: (context, index, realIndex) {
                                return const LoadingBubble(
                                  height: 260,
                                  radius: 15,
                                  margin: EdgeInsets.all(8.0),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                    onComplete: (context, snapshot) {
                      return Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: snapshot.data!.data!.length,
                            options: CarouselOptions(
                              viewportFraction: 0.9,
                              enableInfiniteScroll: false,
                              height: 280.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                            itemBuilder: (context, index, realIndex) {
                              final newsData = snapshot.data!.data![index];
                              return NewsCard(
                                newData: newsData,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomSmoothIndicator(
                            count: snapshot.data!.data!.length,
                            index: currentIndex,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: GoogleBanner(
                  onLoading: ShimmerLoading(
                    child: LoadingBubble(
                      width: AdSize.banner.width.toDouble(),
                      height: AdSize.banner.height.toDouble(),
                      radius: 0,
                    ),
                  ),
                ),
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
                      child: CustomFutureBuilder(
                        future: _compoNewsFuture,
                        onLoading: () {
                          return ShimmerLoading(
                            child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(width: 6),
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsetsDirectional.symmetric(vertical: 6.0),
                              itemCount: 12,
                              itemBuilder: (BuildContext context, int index) {
                                return const LoadingBubble(
                                  height: 60,
                                  width: 60,
                                );
                              },
                            ),
                          );
                        },
                        onRetry: () {
                          setState(() {
                            _initializeCompoNews();
                          });
                        },
                        onError: (snapshot) => const Center(child: Icon(Icons.error)),
                        onComplete: (context, snapshot) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(width: 6),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 6.0),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final newModel = snapshot.data!.data![index];
                              return const NewsChampCard();
                            },
                          );
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
            SliverFillRemaining(
              child: CustomFutureBuilder(
                future: _mostRecentNewsFuture,
                onRetry: () {
                  setState(() {
                    _initializeRecentNews();
                  });
                },
                onLoading: () {
                  return ShimmerLoading(
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) => const SizedBox(height: 5),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        return const ShimmerLoading(
                          child: LoadingBubble(
                            height: 260,
                            radius: 15,
                            margin: EdgeInsetsDirectional.all(8.0),
                          ),
                        );
                      },
                    ),
                  );
                },
                onComplete: (context, snapshot) {
                  return ListView.separated(
                    itemCount: snapshot.data!.data!.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      final newData = snapshot.data!.data![index];
                      return NewsCard(
                        isMessage: true,
                        newData: newData,
                      );
                    },
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
