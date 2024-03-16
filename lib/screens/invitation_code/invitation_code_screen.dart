import 'package:flutter/material.dart';
import 'package:sportk/model/points_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

class InvitationCodeScreen extends StatefulWidget {
  const InvitationCodeScreen({super.key});

  @override
  State<InvitationCodeScreen> createState() => _InvitationCodeScreenState();
}

class _InvitationCodeScreenState extends State<InvitationCodeScreen> {
  late Future<PointsModel> _pointsFuture;
  late CommonProvider _commonProvider;

  void _initializeFuture() {
    _pointsFuture = _commonProvider.getPoints();
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              context.pushAndRemoveUntil(const AppNavBar());
            },
            child: Text(
              context.appLocalization.skip,
            ),
          ),
        ],
      ),
      body: CustomFutureBuilder(
        future: _pointsFuture,
        onRetry: () {
          setState(() {
            _initializeFuture();
          });
        },
        onComplete: (context, snapshot) {
          final points = snapshot.data!;
          String invitationCodePoints = "";
          points.data!.map(
            (e) {
              if (e.id == 1) {
                invitationCodePoints = e.value!;
              }
            },
          ).toSet();
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 30, bottom: 10),
                  child: Text(
                    context.appLocalization.invitationCode,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Text(context.appLocalization.friendsRecomend),
                Row(
                  children: [
                    Text(context.appLocalization.addInvitationCode),
                    Text(
                      "$invitationCodePoints ${context.appLocalization.sportk}",
                      style: TextStyle(
                        color: context.colorPalette.yellowF7A,
                      ),
                    ),
                  ],
                ),
                Text(context.appLocalization.forYouAndYourFriend),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: context.colorPalette.blue1AD4B,
                    contentPadding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 10),
                    hintText: context.appLocalization.enterInvitationCode,
                    hintStyle: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const CustomSvg(MyIcons.ticketStar),
                    ),
                  ),
                ),
                const Spacer(),
                StretchedButton(
                  onPressed: () {},
                  child: Text(context.appLocalization.send),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
