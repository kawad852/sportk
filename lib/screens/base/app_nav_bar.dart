import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/notifications/cloud_messaging_service.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/base/widgets/nav_bar_item.dart';
import 'package:sportk/screens/favorites/favorites_screen.dart';
import 'package:sportk/screens/home/home_screen.dart';
import 'package:sportk/screens/leagues/leagues_screen.dart';
import 'package:sportk/screens/news/news_screen.dart';
import 'package:sportk/screens/wallet/wallet_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';

class AppNavBar extends StatefulWidget {
  final bool initFav;
  const AppNavBar({
    super.key,
    this.initFav = false,
  });

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _currentIndex = 0;
  late PageController _pageController;
  final cloudMessagingService = CloudMessagingService();
  late AuthProvider authProvider;

  final items = [
    MyIcons.football,
    MyIcons.documentText,
    MyIcons.cup,
    MyIcons.starOutlined,
    MyIcons.wallet,
  ];

  List<String> _getTitle(BuildContext context) {
    return [
      context.appLocalization.home,
      context.appLocalization.news,
      context.appLocalization.leagues,
      context.appLocalization.favorites,
      context.appLocalization.myWallet,
    ];
  }

  final screens = [
    const HomeScreen(),
    const NewsScreen(),
    const LeaguesScreen(),
    const FavoritesScreen(),
    const WalletScreen(),
  ];

  void _onSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(_currentIndex);
  }

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _pageController = PageController();
    authProvider.updateDeviceToken(context);
    cloudMessagingService.init(context);
    cloudMessagingService.requestPermission();
    if (widget.initFav) {
      context.favoriteProvider.fetchFavs(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          color: context.colorPalette.homeMatchBubble,
          boxShadow: [
            BoxShadow(
              color: context.colorPalette.blue4F0,
              offset: const Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Row(
          children: screens.map((element) {
            final index = screens.indexOf(element);
            return NavBarItem(
              onTap: () {
                if (index == 0 || index == 1 || index == 2) {
                  _onSelect(index);
                } else {
                  authProvider.checkIfUserAuthenticated(
                    context,
                    callback: () {
                      _onSelect(index);
                    },
                  );
                }
              },
              isSelected: _currentIndex == index,
              icon: items[index],
              title: _getTitle(context)[index],
            );
          }).toList(),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
    );
  }
}
