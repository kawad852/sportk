import 'package:flutter/material.dart';
import 'package:sportk/screens/home/home_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

class InvitationCodeScreen extends StatefulWidget {
  const InvitationCodeScreen({super.key});

  @override
  State<InvitationCodeScreen> createState() => _InvitationCodeScreenState();
}

class _InvitationCodeScreenState extends State<InvitationCodeScreen> {
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
              context.push(const HomeScreen());
            },
            child: Text(
              context.appLocalization.skip,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.only(top: 30, bottom: 10),
              child: Text(
                "Invitation code",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const Text("Did one of your friends recommend SPORTK?"),
            Row(
              children: [
                const Text("Add his invitation code and get "),
                Text(
                  "50 SPORTK",
                  style: TextStyle(
                    color: context.colorPalette.mainYellow,
                  ),
                ),
              ],
            ),
            const Text("For you and your friend."),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                fillColor: context.colorPalette.grey3F,
                contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 10),
                hintText: "Enter the invitation code here",
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
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
