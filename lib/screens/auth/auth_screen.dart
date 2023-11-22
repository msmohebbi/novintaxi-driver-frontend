// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_data.dart';
import '../../providers/settings_data.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/auth/verify_screen.dart';
import '../../screens/auth/intro_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var pageList = [
      const IntroScreen(),
      Provider.of<SettingData>(context).isLogin
          ? const LoginScreen()
          : const SignUpScreen(),
      const VerifyScreen()
    ];
    var pageIndex = Provider.of<SettingData>(context).authPageIndex;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: const Color(0xff264653),
        appBar: AppBar(
          elevation: 0,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Provider.of<SettingData>(context, listen: false).changeIsDark();
              },
              child: Padding(
                padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                child: Provider.of<SettingData>(context).isDark
                    ? Transform.rotate(
                        angle: pi / 8,
                        child: Icon(
                          Icons.mode_night_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ))
                    : Icon(
                        Icons.wb_sunny,
                        color: Theme.of(context).primaryColor,
                      ),
              ),
            ),
          ],
          leading: pageIndex != 0
              ? InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if (pageIndex == 1) {
                      Provider.of<SettingData>(context, listen: false)
                          .setauthPageIndex(0);
                    }
                    if (pageIndex == 2) {
                      Provider.of<AuthData>(context, listen: false)
                          .setUserTempPhone('');
                      Provider.of<SettingData>(context, listen: false)
                          .setauthPageIndex(1);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    // color: Theme.of(context).hintColor,
                  ),
                )
              : null,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: pageList[pageIndex],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: pageIndex == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).hintColor,
                    maxRadius: kToolbarHeight * 0.1,
                  ),
                  const SizedBox(width: kToolbarHeight * 0.1),
                  CircleAvatar(
                    backgroundColor: pageIndex == 1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).hintColor,
                    maxRadius: kToolbarHeight * 0.1,
                  ),
                  const SizedBox(width: kToolbarHeight * 0.1),
                  CircleAvatar(
                    backgroundColor: pageIndex == 2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).hintColor,
                    maxRadius: kToolbarHeight * 0.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
