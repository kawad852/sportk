import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/swap_requests_model.dart';
import 'package:sportk/screens/wallet/widgets/request_text.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class RequestDetalisScreen extends StatelessWidget {
  final SwapData swapData;
  const RequestDetalisScreen({super.key, required this.swapData});

  @override
  Widget build(BuildContext context) {
    String status = "";
    Color colorStatus = Colors.white;
    switch (swapData.statusType) {
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
              "#${swapData.id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 125,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: context.colorPalette.blueF9F,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequsetText(text: "#${swapData.id}"),
                      RequsetText(
                        text: "${context.appLocalization.voucherType}${swapData.voucher!.title!}",
                      ),
                      Row(
                        children: [
                          RequsetText(
                            text: "${context.appLocalization.requestStatus} ",
                          ),
                          RequsetText(
                            text: status,
                            textColor: colorStatus,
                          ),
                        ],
                      ),
                      RequsetText(
                        text:
                            "${context.appLocalization.requestDate}${DateFormat("yyyy/MM/dd").format(swapData.createdAt!)}",
                      ),
                      RequsetText(
                        text:
                            "${context.appLocalization.numberPoints}${swapData.voucher!.points!} ${context.appLocalization.point}",
                      ),
                    ],
                  ),
                  CustomNetworkImage(
                    swapData.voucher!.image!,
                    width: 40,
                    height: 40,
                    radius: MyTheme.radiusPrimary,
                  ),
                ],
              ),
            ),
          ),
          if (swapData.code != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequsetText(
                      text: context.appLocalization.voucherCode,
                      textColor: context.colorPalette.blueD4B,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: context.colorPalette.blue1AD4B,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: RequsetText(
                                text: swapData.code!,
                                textColor: context.colorPalette.blueD4B,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: swapData.code!)).then(
                                (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(context.appLocalization.copiedVoucherCode),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const CustomSvg(MyIcons.voucherCode),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
