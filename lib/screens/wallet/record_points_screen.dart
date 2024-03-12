import 'package:flutter/material.dart';
import 'package:sportk/model/record_points_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/wallet/widgets/points_loading.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class RecordPointsScreen extends StatefulWidget {
  const RecordPointsScreen({super.key});

  @override
  State<RecordPointsScreen> createState() => _RecordPointsScreenState();
}

class _RecordPointsScreenState extends State<RecordPointsScreen> {
  late CommonProvider _commonProvider;
  late Future<RecordPointsModel> _recordPointsFuture;

  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<RecordPointsModel> _initializeFuture(int pageKey) {
    _recordPointsFuture = _commonProvider.getRecordPoints(pageKey);
    return _recordPointsFuture;
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            leadingWidth: 100,
            leading: CustomBack(
              color: context.colorPalette.blueD4B,
            ),
            title: Text(
              context.appLocalization.recordPoints,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: VexPaginator(
              key: _vexKey,
              query: (pageKey) async => _initializeFuture(pageKey),
              onFetching: (snapshot) async => snapshot.data!,
              pageSize: 10,
              onLoading: () => const ShimmerLoading(child: PointsLoading()),
              builder: (context, snapshot) {
                final recordPoints = snapshot.docs as List<RecordData>;
                return recordPoints.isEmpty
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(top: 250),
                        child: Text(
                          context.appLocalization.emptyRecordPoints,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(width: 6),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: snapshot.docs.length + 1,
                        itemBuilder: (context, index) {
                          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                            snapshot.fetchMore();
                          }

                          if (index == snapshot.docs.length) {
                            return VexLoader(snapshot.isFetchingMore);
                          }

                          final element = recordPoints[index];
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: context.colorPalette.blueF9F,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CustomSvg(
                                    element.points! > 0 ? MyIcons.addPoints : MyIcons.minusPoints),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    "${element.points},  ${element.message}",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
