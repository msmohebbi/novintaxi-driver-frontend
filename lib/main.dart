import 'dart:io';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/providers/driver_transport_data.dart';
import 'package:transportationdriver/providers/faq_data.dart';
import 'package:transportationdriver/providers/message_data.dart';
import 'package:transportationdriver/screens/chat_screen.dart';
import 'package:transportationdriver/screens/driver_profile_screen.dart';
import 'package:transportationdriver/screens/faq_screen.dart';
import 'package:transportationdriver/screens/license_view_screen.dart';
import 'package:transportationdriver/screens/loading_screen.dart';
import 'package:transportationdriver/screens/main_screen.dart';
import 'package:transportationdriver/screens/profile_view_screen.dart';
import 'package:transportationdriver/screens/revenue_screen.dart';
import 'package:transportationdriver/screens/vehicle_view_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/search_driver_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'const/themes.dart';
import 'firebase_options.dart';
import 'providers/settings_data.dart';
import 'providers/auth_data.dart';
import 'providers/func_data.dart';
import 'providers/transport_data.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'providers/notification_data.dart';
import 'providers/profile_data.dart';
import 'screens/open_maps_screen.dart';

void main() async {
  initializeDateFormatting('fa_IR', null);
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  timeago.setLocaleMessages('fa', timeago.FaMessages());
  if (kIsWeb) {
    setPathUrlStrategy();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance().then(
    (prefs) {
      var isDark = prefs.getBool("isDark") ?? false;
      if (isDark) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analytics);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingData(),
        ),
        ChangeNotifierProvider(
          create: (_) => DriverTransportData(),
        ),
        // -====================================================================
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
        // -====================================================================
        // No Need Authentication important--------------------------------------
        // -====================================================================
        ChangeNotifierProvider(
          create: (_) => AuthData(),
        ),
        // -====================================================================
        // All Need Authentication-------------------------------------------
        ChangeNotifierProxyProvider<AuthData, ProfileData>(
          update: (context, newAuthData, previousProfileData) =>
              previousProfileData!
                ..updater(
                  newAuthData,
                ),
          create: (BuildContext context) => ProfileData(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => ClientsData(),
        // ),

        ChangeNotifierProvider(
          create: (_) => DriverData(),
        ),

        ChangeNotifierProvider(
          create: (_) => TransportData(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationData(),
        ),
        ChangeNotifierProvider(
          create: (_) => MessageData(),
        ),
        // No Need Authentication--------------------------------------

        ChangeNotifierProvider(
          create: (_) => FuncData(),
        ),

        ChangeNotifierProvider(
          create: (_) => FAQData(),
        ),
      ],
      builder: (context, child) {
        return const MyMaterial();
      },
    );
  }
}

class MyMaterial extends StatelessWidget {
  const MyMaterial({
    super.key,
  });

  // final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "Main Navigator");

  @override
  Widget build(BuildContext context) {
    Widget checkAuth(Widget page) {
      if (Provider.of<AuthData>(context).accessToken != "") {
        return page;
      } else {
        return const AuthScreen();
      }
    }

    return MaterialApp(
      // navigatorKey: navigatorKey,
      scrollBehavior: MyCustomScrollBehavior(),
      locale: const Locale("fa"),
      debugShowCheckedModeBanner: false,
      title: "حمل و نقل",
      theme: Provider.of<SettingData>(context).isDark ? darkTheme : lightTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
      routes: {
        "/mapscreen": (ctx) => checkAuth(const OpenMapsScreen()),
        "/search": (ctx) => checkAuth(const SearchDriverScreen()),
        "/faqs": (ctx) => checkAuth(const FAQScreen()),
        "/support": (ctx) => checkAuth(const ChatScreen()),
        ProfileViewScreen.routeName: (ctx) => checkAuth(
              const ProfileViewScreen(),
            ),
        VehicleViewScreen.routeName: (ctx) => checkAuth(
              const VehicleViewScreen(),
            ),
        LicenseViewScreen.routeName: (ctx) => checkAuth(
              const LicenseViewScreen(),
            ),
        RevenueScreen.routeName: (ctx) => checkAuth(
              const RevenueScreen(),
            ),
      },
      // onGenerateRoute: (route) {},
      home: Provider.of<AuthData>(context).accessToken != ""
          ? !Provider.of<DriverData>(context).isInitialized
              ? const LoadingScreen()
              : Provider.of<DriverData>(context).isVerify
                  ? const MainScreen()
                  : const DriverProfileScreen()
          : const AuthScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
