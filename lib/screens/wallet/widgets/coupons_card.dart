import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/model/vouchers_model.dart';
import 'package:sportk/model/vouchers_replaced_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/wallet/request_detalis_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class CouponsCard extends StatefulWidget {
  final VouchersData vouchersData;

  const CouponsCard({super.key, required this.vouchersData});

  @override
  State<CouponsCard> createState() => _CouponsCardState();
}

class _CouponsCardState extends State<CouponsCard> {
  late CommonProvider _commonProvider;

  void replacedvoucher() {
    ApiFutureBuilder<VoucherReplacedModel>().fetch(
      context,
      future: () async {
        final voucherFuture = _commonProvider.replacedVoucher(widget.vouchersData.id!);
        return voucherFuture;
      },
      onComplete: (snapshot) {
        context.push(
          RequestDetalisScreen(
            swapData: snapshot.data!,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorPalette.grey2F2,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Selector<AuthProvider, UserData>(
              selector: (context, provider) => provider.user,
              builder: (context, user, child) {
                return CustomNetworkImage(
                  widget.vouchersData.image!,
                  width: 130,
                  height: 114,
                  onTap: () {
                    user.points! < widget.vouchersData.points!
                        ? context.showDialog(
                            titleText: context.appLocalization.numberPoints,
                            bodyText: context.appLocalization.noPointEnough,
                          )
                        : context
                            .showDialog(
                             titleText: context.appLocalization.replacePoints,
                            bodyText: context.appLocalization.pointsForVoucher(
                              widget.vouchersData.points.toString(),
                              widget.vouchersData.title!,
                            ),
                          )
                            .then(
                            (value) async {
                              if (value != null) {
                                replacedvoucher();
                              }
                            },
                          );
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MySharedPreferences.language == LanguageEnum.arabic
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 25.0,
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                  color: context.colorPalette.walletContainerColor,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.vouchersData.points.toString(),
                                      style: TextStyle(
                                        color: context.colorPalette.blueD4B,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const CustomSvg(
                                      MyIcons.coin,
                                      width: 15,
                                      fixedColor: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                              color: context.colorPalette.walletContainerColor,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  context.appLocalization.winners,
                                  style: TextStyle(
                                    color: context.colorPalette.blueD4B,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  widget.vouchersData.numberOfCodes.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Text(
              widget.vouchersData.title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
