import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportk/screens/wallet/widgets/coupons_card.dart';
import 'package:sportk/screens/wallet/widgets/share_app_text.dart';
import 'package:sportk/screens/wallet/widgets/wallet_button.dart';
import 'package:sportk/screens/wallet/widgets/watch_ad_button.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/screens/wallet/widgets/wallet_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: const CustomSvg(MyIcons.sort),
            ),
            title: Text(
              context.appLocalization.myWallet,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const WalletCard(),
                  WatchAdButton(onPressed: () {}),
                  Row(
                    children: [
                      WalletButton(
                        icon: MyIcons.moneyTime,
                        text: context.appLocalization.recordPoints,
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      WalletButton(
                        icon: MyIcons.replacementRequests,
                        text: context.appLocalization.replacementRequests,
                        onPressed: () {},
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
                      borderRadius: BorderRadius.circular(10),
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
                          width: 180,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.colorPalette.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "invitation Code",
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(const ClipboardData(text: "invitation Code")).then(
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
                  const ShareAppText(),
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
                        context.appLocalization.coupons,
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (BuildContext context, int index) {
                  return const CouponsCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
