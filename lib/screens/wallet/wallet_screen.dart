import 'package:flutter/material.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';
import 'package:sportk/widgets/wallet_card.dart';

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
            leading: IconButton(
              onPressed: () {},
              icon: const CustomSvg(MyIcons.sort),
            ),
            title: const Center(
              child: Text(
                "My Wallet",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 20),
            sliver: SliverToBoxAdapter(
              child: WalletCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                StretchedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 10,
                          child: Text(
                            "Watch an ad for 10 sportk",
                            textAlign: TextAlign.center,
                          )),
                      Text("data")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
