import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportk/model/points_model.dart';
import 'package:sportk/model/user_model.dart';
import 'package:sportk/model/vouchers_model.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/profile/profile_screen.dart';
import 'package:sportk/screens/wallet/record_points_screen.dart';
import 'package:sportk/screens/wallet/swap_requests_screen.dart';
import 'package:sportk/screens/wallet/widgets/coupons_card.dart';
import 'package:sportk/screens/wallet/widgets/share_app_text.dart';
import 'package:sportk/screens/wallet/widgets/wallet_button.dart';
import 'package:sportk/screens/wallet/widgets/wallet_card.dart';
import 'package:sportk/screens/wallet/widgets/wallet_loading.dart';
import 'package:sportk/screens/wallet/widgets/watch_ad_button.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/ads/google_rewarded.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/menu_button.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

import 'widgets/vouchers_loading.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with AutomaticKeepAliveClientMixin {
  late Future<List<dynamic>> _futures;
  late AuthProvider _authProvider;
  late Future<UserModel> _userFuture;
  late Future<PointsModel> _pointsFuture;

  late CommonProvider _commonProvider;
  late Future<VouchersModel> _vouchersFuture;

  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<List<dynamic>> _initializeFutures() async {
    _userFuture = _authProvider.getUserProfile(context, MySharedPreferences.user.id!);
    _pointsFuture = _commonProvider.getPoints();
    return Future.wait([_userFuture, _pointsFuture]);
  }

  Future<VouchersModel> _initializeVouchersFuture(int pageKey) {
    _vouchersFuture = _commonProvider.getVouchers(pageKey);
    return _vouchersFuture;
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _commonProvider = context.commonProvider;
    _futures = _initializeFutures();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: const ProfileScreen(),
      body: RefreshIndicator(
        onRefresh: ()async{
          setState(() {
           _futures = _initializeFutures();
           _vexKey.currentState!.refresh();
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              leading: const MenuButton(),
              title: Text(context.appLocalization.myWallet),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: CustomFutureBuilder(
                  future: _futures,
                  onRetry: () {
                    setState(() {
                      _futures = _initializeFutures();
                    });
                  },
                  onLoading: () => const ShimmerLoading(child: WalletLoading()),
                  onComplete: (context, snapshot) {
                    final user = snapshot.data![0] as UserModel;
                    final points = snapshot.data![1] as PointsModel;
                    String invitationCodePoints = "";
                    String adPoints = "";
                    points.data!.map(
                      (e) {
                        if (e.id == 1) {
                          invitationCodePoints = e.value!;
                        }
                        if (e.id == 5) {
                          adPoints = e.value!;
                        }
                      },
                    ).toSet();
                    return Column(
                      children: [
                        const WalletCard(),
                        GoogleRewarded(
                          points: int.parse(adPoints),
                          onClose: () {},
                          child: WatchAdButton(
                            points: adPoints,
                            onPressed: () {},
                          ),
                        ),
                        Row(
                          children: [
                            WalletButton(
                              icon: MyIcons.moneyTime,
                              text: context.appLocalization.recordPoints,
                              onPressed: () {
                                context.push(const RecordPointsScreen());
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            WalletButton(
                              icon: MyIcons.replacementRequests,
                              text: context.appLocalization.replacementRequests,
                              onPressed: () {
                                context.push(const SwapRequestsScreen());
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                            color: context.colorPalette.blueF9F,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CustomSvg(MyIcons.ticketStar),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(start: 2, end: 2),
                                child: Text(
                                  context.appLocalization.invitationCode,
                                  style: TextStyle(
                                    color: context.colorPalette.blueD4B,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                width: 170,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: context.colorPalette.walletContainerColor,
                                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                ),
                                child: Text(
                                  user.data!.invitationCode!,
                                  style: TextStyle(
                                    color: context.colorPalette.blueD4B,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: user.data!.invitationCode!)).then(
                                    (value) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(context.appLocalization.copiedInvitionCode),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const CustomSvg(MyIcons.copyCode),
                              ),
                            ],
                          ),
                        ),
                        ShareAppText(points: invitationCodePoints),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const CustomSvg(MyIcons.coupons),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              context.appLocalization.vouchers,
                              style: TextStyle(
                                color: context.colorPalette.blueD4B,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            VexPaginator(
              key: _vexKey,
              query: (pageKey) async => _initializeVouchersFuture(pageKey),
              onFetching: (snapshot) async => snapshot.data!,
              pageSize: 10,
              sliver: true,
              onLoading: () => const ShimmerLoading(child: VouchersLoading()),
              builder: (context, snapshot) {
                final vouchers = snapshot.docs as List<VouchersData>;
                return vouchers.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            context.appLocalization.noVouchersAvailable,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            childCount: snapshot.docs.length + 1,
                            (context, index) {
                              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                snapshot.fetchMore();
                              }
        
                              if (index == snapshot.docs.length) {
                                return VexLoader(snapshot.isFetchingMore);
                              }
        
                              final element = vouchers[index];
                              return CouponsCard(vouchersData: element);
                            },
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
