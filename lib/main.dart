import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sportk/providers/app_provider.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/screens/intro/intro_screen.dart';
import 'package:sportk/screens/registration/registration_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';

// mhyar

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  final data = message.notification;
  log("ReceivedNotification::\nType::onBackgroundMessage\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData::${message.data}");
}

// before merge

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreferences.init();
  unawaited(MobileAds.instance.initialize());
  // MySharedPreferences.clearStorage();
  // MySharedPreferences.isPassedIntro = false;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => FootBallProvider()),
        ChangeNotifierProvider(create: (context) => CommonProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider _authProvider;
  late CommonProvider _commonProvider;

  Widget _toggleRoute(BuildContext context) {
    if (_authProvider.user.id != null) {
      return const AppNavBar();
    } else {
      if (MySharedPreferences.isPassedIntro) {
        return const RegistrationScreen();
      } else {
        return const IntroScreen();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _commonProvider = context.commonProvider;
    _authProvider.initializeLocale(context);
    _authProvider.initUser();
    final v = PlatformDispatcher.instance.locale.countryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final seedColorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF032D4B),
          primary: const Color(0xFF032D4B),
          brightness: appProvider.appTheme == ThemeEnum.light ? Brightness.light : Brightness.dark,
        );
        return MaterialApp(
          navigatorKey: navigatorKey,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(appProvider.appLocale.languageCode),
          theme: MyTheme().materialTheme(context, seedColorScheme),
          home: _toggleRoute(context),
          // home: const PaginationTestScreen(),
        );
      },
    );
  }
}
