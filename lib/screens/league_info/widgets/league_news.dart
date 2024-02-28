import 'package:flutter/material.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/widgets/news_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueNews extends StatefulWidget {
  const LeagueNews({super.key});

  @override
  State<LeagueNews> createState() => _LeagueNewsState();
}

class _LeagueNewsState extends State<LeagueNews> {
  late CommonProvider _commonProvider;
  late Future<NewModel> _newsFuture;

  void _initializeNews() {
    _newsFuture = _commonProvider.fetchNews(1);
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _initializeNews();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _newsFuture,
      onRetry: () {
        setState(() {
          _initializeNews();
        });
      },
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
      onComplete: (context, snapshot) {
        return ListView.separated(
          itemCount: snapshot.data!.data!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          itemBuilder: (BuildContext context, int index) {
            final newData = snapshot.data!.data![index];
            return NewsCard(
              newData: newData,
            );
          },
        );
      },
    );
  }
}
