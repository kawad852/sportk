import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
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
import 'package:sportk/utils/shared_pref.dart';
import 'package:store_redirect/store_redirect.dart';

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

  final RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 1,
    minLaunches: 2,
    remindDays: 2,
    remindLaunches: 2,
    appStoreIdentifier: "com.eascore.wecan",
    googlePlayIdentifier: "com.eascore.wecan",
  );

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

  Future<bool> _checkPermission(BuildContext context) async {
    const permission = Permission.audio;
    final status = await permission.status;
    if (status != PermissionStatus.granted) {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else if (result == PermissionStatus.denied) {
        return false;
      } else if (result == PermissionStatus.permanentlyDenied) {
        if (context.mounted) {
          //_showLocationErrorSnackBar(context, source);
        }
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _pageController = PageController();
    authProvider.updateDeviceToken(context);
    cloudMessagingService.init(context);
    // MySharedPreferences.reviewCount = MySharedPreferences.reviewCount + 1;
    // if (MySharedPreferences.reviewCount == 2) {
    //   // dialog
    // }
    _rateMyApp.init().then((_) {
      // TODO: Comment out this if statement to test rating dialog (Remember to uncomment)
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          title: context.appLocalization.rateUs,
          message: context.appLocalization.rateMsg,
          actionsBuilder: (context, stars) {
            return [
              TextButton(
                child: Text(context.appLocalization.remindMeLater),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(context.appLocalization.rate),
                onPressed: () {
                  if (stars != null) {
                    _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed).then((_) {
                      _rateMyApp.save();
                      Navigator.pop(context);
                    });
                    if (stars <= 2) {
                      Navigator.pop(context);
                    } else if (stars <= 5) {
                      StoreRedirect.redirect(
                        androidAppId: "com.eascore.wecan",
                        iOSAppId: "com.eascore.wecan",
                      );
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ];
          },
          dialogStyle: const DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: const StarRatingOptions(),
        );
      }
    });
    cloudMessagingService.requestPermission();
    _checkPermission(context);
    if (widget.initFav) {
      context.favoriteProvider.fetchFavs(context);
    }

    MySharedPreferences.showAd = true;
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
