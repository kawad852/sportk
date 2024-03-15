import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/auth_model.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, UserData>(
      selector: (context, provider) => provider.user,
      builder: (context, userData, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: context.colorPalette.blueD4B,
                    child: CircleAvatar(
                      radius: 26.0,
                      child: ClipOval(
                        child: CustomNetworkImage(
                          userData.profileImg!,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          userData.email!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorPalette.text97,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 35.0,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colorPalette.grey2F2,
              ),
              child: Row(
                children: [
                  Text(
                    "${userData.points}",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const CustomSvg(MyIcons.coin),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
