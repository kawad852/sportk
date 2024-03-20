import 'package:flutter/material.dart';
import 'package:sportk/model/swap_requests_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/wallet/request_detalis_screen.dart';
import 'package:sportk/screens/wallet/widgets/points_loading.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class SwapRequestsScreen extends StatefulWidget {
  const SwapRequestsScreen({super.key});

  @override
  State<SwapRequestsScreen> createState() => _SwapRequestsScreenState();
}

class _SwapRequestsScreenState extends State<SwapRequestsScreen> {
  late CommonProvider _commonProvider;
  late Future<SwapRequestsModel> _swapFuture;

  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<SwapRequestsModel> _initializeFuture(int pageKey) {
    _swapFuture = _commonProvider.getSwapRequests(pageKey);
    return _swapFuture;
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
              context.appLocalization.replacementRequests,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          VexPaginator(
            key: _vexKey,
            query: (pageKey) async => _initializeFuture(pageKey),
            onFetching: (snapshot) async => snapshot.data!,
            pageSize: 10,
            sliver: true,
            onLoading: () {
              return const ShimmerLoading(child: PointsLoading());
            },
            builder: (context, snapshot) {
              final swapRequests = snapshot.docs as List<SwapData>;
              return swapRequests.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          context.appLocalization.noSwapRequests,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : SliverList.separated(
                      separatorBuilder: (context, index) => const SizedBox(width: 6),
                      itemCount: snapshot.docs.length + 1,
                      itemBuilder: (context, index) {
                        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }

                        if (index == snapshot.docs.length) {
                          return VexLoader(snapshot.isFetchingMore);
                        }

                        final element = swapRequests[index];
                        String status = "";
                        Color colorStatus = Colors.white;
                        switch (element.statusType) {
                          case 0:
                            status = context.appLocalization.rejected;
                            colorStatus = context.colorPalette.penddingColor;
                          case 1:
                            status = context.appLocalization.replaced;
                            colorStatus = context.colorPalette.green057;
                          case 2:
                            status = context.appLocalization.pending;
                            colorStatus = context.colorPalette.penddingColor;
                        }
                        return InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            context.push(RequestDetalisScreen(swapData: element));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colorPalette.blueF9F,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomNetworkImage(
                                      element.voucher!.image!,
                                      width: 40,
                                      height: 40,
                                      radius: MyTheme.radiusPrimary,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "#${element.id}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${context.appLocalization.requestStatus} ",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              status,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: colorStatus,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
