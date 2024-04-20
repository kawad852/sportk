import 'package:flutter/material.dart';
import 'package:sportk/helper/validation_helper.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/model/invitation_code_model.dart';
import 'package:sportk/model/points_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/auth_provider.dart';
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
  late CommonProvider _commonProvider;
  late AuthProvider _authProvider;
  late Future<PointsModel> _pointsFuture;
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? isSuccsessCode;

  void _initializeFuture() {
    _pointsFuture = _commonProvider.getPoints();
  }

  void updateInvitationStatus() {
    ApiFutureBuilder<AuthModel>().fetch(
      context,
      future: () async {
        final updateStatus = _authProvider.updateProfile(
          context,
          {
            "invitation_code_status": 1,
          },
        );
        return updateStatus;
      },
      onComplete: (snapshot) {
        context.pushAndRemoveUntil(const AppNavBar());
      },
    );
  }

  void verifyCode() {
    if (_formKey.currentState!.validate()) {
      ApiFutureBuilder<InvitationCodeModel>().fetch(
        context,
        future: () async {
          final verifyCode = _commonProvider.verifyInvitationCode(_codeController.text.trim());
          return verifyCode;
        },
        onComplete: (snapshot) {
          if (snapshot.code == 500) {
            setState(() {
              isSuccsessCode = false;
            });
          } else if (snapshot.code == 200) {
            setState(() {
              isSuccsessCode = true;
            });
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
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
              updateInvitationStatus();
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
          return Form(
            key: _formKey,
            child: Padding(
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
                        "$invitationCodePoints ${context.appLocalization.point} ",
                        style: TextStyle(
                          color: context.colorPalette.yellowF7A,
                        ),
                      ),
                    ],
                  ),
                  Text(context.appLocalization.forYouAndYourFriend),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _codeController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: context.colorPalette.blue1AD4B,
                        hintText: context.appLocalization.enterInvitationCode,
                        hintStyle: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                        suffixIcon: isSuccsessCode == null
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: null,
                                icon: CustomSvg(
                                  isSuccsessCode! ? MyIcons.codeSuccess : MyIcons.codeWrong,
                                  fixedColor: true,
                                ),
                              ),
                        prefixIcon: const IconButton(
                          onPressed: null,
                          icon: CustomSvg(MyIcons.ticketStar),
                        ),
                      ),
                      validator: (value) {
                        return value!.isEmpty ? ValidationHelper.general(context, value) : null;
                      },
                    ),
                  ),
                  isSuccsessCode == null
                      ? const SizedBox.shrink()
                      : isSuccsessCode!
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.appLocalization.congratulations,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "$invitationCodePoints ${context.appLocalization.point} ",
                                      style: TextStyle(
                                        color: context.colorPalette.yellowF7A,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      context.appLocalization.youAndFriend,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  context.appLocalization.dontForgetCollect,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Text(
                              context.appLocalization.wrongInvitationCode,
                              textAlign: TextAlign.center,
                            ),
                  const Spacer(),
                  StretchedButton(
                    onPressed: () {
                      isSuccsessCode == true
                          ? context.pushAndRemoveUntil(const AppNavBar())
                          : verifyCode();
                    },
                    child: Text(
                      isSuccsessCode == true
                          ? context.appLocalization.homePage
                          : context.appLocalization.send,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
