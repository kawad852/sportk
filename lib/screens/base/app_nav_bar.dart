import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/notifications/cloud_messaging_service.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/base/widgets/nav_bar_item.dart';
import 'package:sportk/screens/favorites/favorites_screen.dart';
import 'package:sportk/screens/home/home_screen.dart';
import 'package:sportk/screens/news/news_screen.dart';
import 'package:sportk/screens/wallet/wallet_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _currentIndex = 0;
  final cloudMessagingService = CloudMessagingService();
  late AuthProvider authProvider;

  final items = [
    MyIcons.football,
    MyIcons.documentText,
    MyIcons.starOutlined,
    MyIcons.wallet,
  ];

  final screens = [
    const HomeScreen(),
    const NewsScreen(),
    const FavoritesScreen(),
    const WalletScreen(),
  ];

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateDeviceToken(context);
    cloudMessagingService.init(context);
    cloudMessagingService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    bool withNotch = MediaQuery.of(context).viewPadding.bottom > 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        height: withNotch ? 95 : 85,
        width: context.mediaQuery.width,
        decoration: BoxDecoration(
          color: context.colorPalette.greyAF8,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((element) {
            final index = items.indexOf(element);
            return NavBarItem(
              onTap: () {
                // if (index == 4 && authProvider.user == null) {
                //   authProvider.toggleGuestRegistration(
                //     context,
                //     callback: () {
                //       setState(() {
                //         _currentIndex = index;
                //       });
                //     },
                //   );
                // } else {
                setState(() {
                  _currentIndex = index;
                });
                // }
              },
              isSelected: _currentIndex == index,
              icon: element,
            );
          }).toList(),
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}
