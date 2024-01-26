// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sportk/model/schedule_and_results_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/wallet/wallet_screen.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';

import '../news/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ScheduleAndResultsModel> _scheduleAndResultsfuture;
  late AuthProvider _authProvider;

  Future<ScheduleAndResultsModel> _initFuture() {
    final data = ApiService<ScheduleAndResultsModel>().build(
      url: ApiUrl.scheduleAndResults,
      isPublic: true,
      apiType: ApiType.get,
      builder: ScheduleAndResultsModel.fromJson,
    );
    return data;
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _initFuture();
  }

  @override
  Widget build(BuildContext context) {
    // final time = DateTime(2024, 01, 21).millisecondsSinceEpoch;
    // print("time:: $time");
    return Scaffold(
        body:
            //  CustomFutureBuilder(
            //   future: _scheduleAndResultsfuture,
            //   onRetry: () {},
            //   onComplete: ((context, snapshot) {
            //     return
            CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          leading: IconButton(
            onPressed: () {
              context.push(const WalletScreen());
            },
            icon: const CustomSvg(MyIcons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push(const NewsScreen());
              },
              icon: const CustomSvg(MyIcons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const CustomSvg(MyIcons.calender),
            ),
            Switch(
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Tuesday 12-12-2024",
              style: context.textTheme.labelMedium,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList.separated(
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeagueTile(),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: context.colorPalette.blue1FC,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const Text("Madrid"),
                        const CustomNetworkImage(
                          kFakeImage,
                          radius: 0,
                          width: 25,
                          height: 25,
                          margin: EdgeInsetsDirectional.only(start: 10, end: 6),
                        ),
                        const Text("2"),
                        const SizedBox(width: 35),
                        const Text("2"),
                        const CustomNetworkImage(
                          kFakeImage,
                          radius: 0,
                          width: 25,
                          height: 25,
                          margin: EdgeInsetsDirectional.only(start: 10, end: 6),
                        ),
                        const Text("Madrid"),
                        const Spacer(),
                        Transform.rotate(
                          angle: -pi / 2,
                          child: Container(
                            height: 20,
                            width: 40,
                            padding: EdgeInsets.all(3),
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
                  ),
                ],
              );
            },
          ),
        ),
      ],
    )
        // }),
        );
  }
}
