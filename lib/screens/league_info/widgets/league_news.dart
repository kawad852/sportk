import 'package:flutter/material.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/widgets/news_card.dart';
import 'package:sportk/screens/news/widgets/news_empty_result.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class NewTab extends StatefulWidget {
  final int id;
  final NewTypeEnum type;

  const NewTab({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  State<NewTab> createState() => _NewTabState();
}

class _NewTabState extends State<NewTab> {
  late CommonProvider _commonProvider;

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
  }

  @override
  Widget build(BuildContext context) {
    return VexPaginator(
      query: (pageKey) async => _commonProvider.fetchNews(pageKey, url: '${ApiUrl.news}/${widget.type == NewTypeEnum.league ? '${BlogsType.competitions(widget.id)}?locale=${MySharedPreferences.language}' : '${BlogsType.teams(widget.id)}?locale=${MySharedPreferences.language}'}'),
      onFetching: (snapshot) async => snapshot.data!,
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
          return const NewsEmptyResult();
        }
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          itemBuilder: (BuildContext context, int index) {
            final newData = snapshot.docs[index] as NewData;
            return NewsCard(
              newData: newData,
            );
          },
        );
      },
    );
  }
}
