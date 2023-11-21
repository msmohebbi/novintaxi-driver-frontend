import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

Color baseColor = TinyColor.fromColor(const Color(0xffE9C46A)).darken().color;
Color revColor = const Color(0xff264653);
MaterialColor myColorForLight = MaterialColor(
  500,
  <int, Color>{
    50: baseColor,
    100: baseColor,
    200: baseColor,
    300: baseColor,
    400: baseColor,
    500: baseColor,
    600: baseColor,
    700: baseColor,
    800: baseColor,
    900: baseColor,
  },
);

Color get darkerBaseColor {
  return TinyColor.fromColor(
    Color.fromARGB(
      baseColor.alpha,
      baseColor.red,
      baseColor.green,
      baseColor.blue,
    ),
  ).lighten().saturate().color;
}

MaterialColor myColorForDark = MaterialColor(500, <int, Color>{
  50: darkerBaseColor,
  100: darkerBaseColor,
  200: darkerBaseColor,
  300: darkerBaseColor,
  400: darkerBaseColor,
  500: darkerBaseColor,
  600: darkerBaseColor,
  700: darkerBaseColor,
  800: darkerBaseColor,
  900: darkerBaseColor,
});

final lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'IRANYekan'),
  primaryTextTheme:
      ThemeData.light().primaryTextTheme.apply(fontFamily: 'IRANYekan'),
  appBarTheme: const AppBarTheme().copyWith(
    foregroundColor: revColor,
    scrolledUnderElevation: 0,
  ),
  listTileTheme: const ListTileThemeData().copyWith(
    iconColor: revColor,
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: myColorForLight,
    primary: myColorForLight[600],
    onPrimary: Colors.grey[900],
    background: Colors.white,
    surfaceTint: myColorForLight.shade400.withAlpha(0),
    error: Colors.redAccent,
  ),
  iconTheme: IconThemeData(color: revColor),
  primaryIconTheme: IconThemeData(color: revColor),
  primaryColor: revColor,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[200],
  hintColor: Colors.grey[700],
  dialogBackgroundColor: Colors.grey[100],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'IRANYekan',
      ),
  primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
        fontFamily: 'IRANYekan',
      ),
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: revColor,
    foregroundColor: Colors.grey[400],
    scrolledUnderElevation: 0,
  ),
  listTileTheme: const ListTileThemeData().copyWith(
    iconColor: Colors.grey[300],
  ),
  brightness: Brightness.dark,
  applyElevationOverlayColor: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: myColorForDark,
    primary: myColorForDark[600],
    onPrimary: Colors.grey[900],
    background: revColor,
    surfaceTint: myColorForDark.shade400.withAlpha(0),
    error: Colors.redAccent,
    brightness: Brightness.dark,
  ),
  iconTheme: IconThemeData(color: Colors.grey[300]),
  primaryIconTheme: IconThemeData(color: Colors.grey[300]),
  primaryColor: Colors.grey[300],
  scaffoldBackgroundColor: revColor,
  cardColor: Colors.grey[900],
  hintColor: Colors.grey[400],
  shadowColor: Colors.white24,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: revColor,
  ),
);
