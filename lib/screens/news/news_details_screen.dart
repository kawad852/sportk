import 'package:flutter/material.dart';
import 'package:sportk/model/new_details_model.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/news/widgets/new_detail_comment_section.dart';
import 'package:sportk/screens/news/widgets/news_card.dart';
import 'package:sportk/screens/news/widgets/news_detalis_card.dart';
import 'package:sportk/screens/news/widgets/news_empty_result.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:sportk/widgets/ads/google_interstitial.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class NewsDetailsScreen extends StatefulWidget {
  final int newId;
  const NewsDetailsScreen({
    super.key,
    required this.newId,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  late Future<NewDetailsModel> _newFuture;

  int get _newId => widget.newId;

  void _initializeNew() {
    _newFuture = ApiService<NewDetailsModel>().build(
      weCanUrl: '${ApiUrl.news}/$_newId',
      isPublic: false,
      apiType: ApiType.get,
      additionalHeaders: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      builder: NewDetailsModel.fromJson,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeNew();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleInterstitial(
      child: CustomFutureBuilder(
        future: _newFuture,
        withBackgroundColor: true,
        onRetry: () {
          setState(() {
            _initializeNew();
          });
        },
        onComplete: (context, snapshot) {
          final newData = snapshot.data!.data!;
          return Scaffold(
            bottomNavigationBar: const BottomAppBar(
              child: GoogleBanner(),
            ),
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  leadingWidth: 120,
                  pinned: true,
                  leading: CustomBack(),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  sliver: SliverToBoxAdapter(
                    child: NewsDetailsCard(newData: newData, source: newData.source),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  sliver: SliverToBoxAdapter(
                    child: NewDetailsCommentSection(newId: _newId),
                  ),
                ),
                if (newData.tags!.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20,
                        bottom: 5,
                      ),
                      child: Text(
                        context.appLocalization.moreNews,
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (newData.tags!.isNotEmpty)
                  VexPaginator(
                    query: (pageKey) async => context.commonProvider.fetchNews(pageKey, url: '${BlogsType.tag(newData.tags!.first.id!)}?locale=${MySharedPreferences.language}'),
                    onFetching: (snapshot) async => snapshot.data!,
                    sliver: true,
                    pageSize: 10,
                    onLoading: () {
                      return ShimmerLoading(
                        child: ListView.separated(
                          itemCount: 10,
                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
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
                    builder: (context, snapshot) {
                      if (snapshot.docs.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: NewsEmptyResult(),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsetsDirectional.all(20),
                        sliver: SliverList.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final newData = snapshot.docs[index] as NewData;
                            return NewsCard(
                              newData: newData,
                            );
                          },
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
