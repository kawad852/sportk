import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/home/widgets/team_widget.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class HomeBubble extends StatefulWidget {
  final DateTime date;
  final int leagueId;

  const HomeBubble({
    super.key,
    required this.date,
    required this.leagueId,
  });

  @override
  State<HomeBubble> createState() => _HomeBubbleState();
}

class _HomeBubbleState extends State<HomeBubble> with AutomaticKeepAliveClientMixin {
  late Future<LeagueByDateModel> _future;

  Future<LeagueByDateModel> _fetchLeagueByDate() {
    final snapshot = ApiService<LeagueByDateModel>().build(
      sportsUrl: '${ApiUrl.compoByDate}/${DateFormat('yyyy-MM-dd').format(widget.date)}${ApiUrl.auth}&filters=fixtureLeagues:${widget.leagueId}&include=state;participants;statistics.type',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueByDateModel.fromJson,
    );
    return snapshot;
  }

  void _initializeFuture() {
    _future = _fetchLeagueByDate();
  }

  @override
  void initState() {
    super.initState();
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder(
      future: _future,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return ShimmerLoading(
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 5),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const LoadingBubble(
                height: 65,
              );
            },
          ),
        );
      },
      onComplete: (context, snapshot) {
        return ListView.separated(
          itemCount: snapshot.data!.data!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 5),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = snapshot.data!.data![index];
            return Container(
              height: 65,
              decoration: BoxDecoration(
                color: context.colorPalette.blue1FC,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TeamWidget(
                          participant: data.participants![0],
                          reverse: false,
                        ),
                        const Text("2"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: CircleAvatar(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("2"),
                        TeamWidget(
                          participant: data.participants![1],
                          reverse: true,
                        ),
                      ],
                    ),
                  ),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: Container(
                      height: 20,
                      width: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: context.colorPalette.red000,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Live",
                        style: context.textTheme.labelSmall!.copyWith(
                          color: context.colorPalette.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
