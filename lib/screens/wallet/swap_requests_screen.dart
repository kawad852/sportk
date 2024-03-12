import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class SwapRequestsScreen extends StatefulWidget {
  const SwapRequestsScreen({super.key});

  @override
  State<SwapRequestsScreen> createState() => _SwapRequestsScreenState();
}

class _SwapRequestsScreenState extends State<SwapRequestsScreen> {
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
          SliverToBoxAdapter(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 6),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: context.colorPalette.blueF9F,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        kFakeImage,
                        width: 40,
                        height: 40,
                        radius: MyTheme.radiusPrimary,
                      ),
                      Column(
                        children: [
                          Text("#12546546"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
