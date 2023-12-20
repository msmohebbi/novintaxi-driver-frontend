// ignore_for_file: use_build_context_synchronously, unnecessary_string_escapes

import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/backend/api.dart';
import 'package:novintaxidriver/backend/api_endpoints.dart';
import 'package:novintaxidriver/providers/profile_data.dart';
import '../../backend/auth.dart';
import '../../providers/auth_data.dart';

// import 'package:http/http.dart' as htp;

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  VerifyScreenState createState() => VerifyScreenState();
}

class VerifyScreenState extends State<VerifyScreen> {
  final _pinController = TextEditingController();

  bool isVerifing = false;
  bool isVerifyPressed = false;
  bool isResending = false;

  Future<void> reSendPass() async {
    if (isResending) {
      return;
    }
    setState(() {
      isResending = true;
    });

    String snackText = "";
    Color snackColor = Theme.of(context).colorScheme.error;
    var username = Provider.of<AuthData>(context, listen: false).cuserTempPhone;
    var lastPassSent = Provider.of<AuthData>(context, listen: false).lastSmsSend;
    var nowDateTime = DateTime.now().millisecondsSinceEpoch;
    // bool isrequestedPass = true;
    if (lastPassSent + (2 * 60 * 1000) < nowDateTime) {
      await Auth().requestPass(username);
      // await Future.delayed(Duration(seconds: 4));
      await Provider.of<AuthData>(context, listen: false).setLastSmsSend(DateTime.now().millisecondsSinceEpoch);
      snackText = "کد تایید به شماره تلفن شما ارسال شد";
    } else {
      snackText = "لطفا تا گذشت دو دقیقه از ارسال پیام قبلی منتظر بمانید";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackText),
        backgroundColor: snackColor,
      ),
    );
    setState(() {
      isResending = false;
    });
  }

  Future<void> verifyUser() async {
    if (isVerifing) {
      return;
    }
    setState(() {
      isVerifing = true;
    });
    String finalPass = _pinController.text;
    String finalUsername = Provider.of<AuthData>(context, listen: false).cuserTempPhone;

    String errorString = "خطا در ورود";
    try {
      var loginData = await Auth().login(finalUsername, finalPass);
      if (loginData["access"] != null) {
        // bool isChangePass =
        //     await Auth().changePass(finalUsername, loginData["access"]!);
        // if (isChangePass) {
        await Provider.of<AuthData>(context, listen: false).saveCredentials(loginData["refresh"]!, loginData["access"]!);
        await Provider.of<ProfileData>(context, listen: false).getProfile();
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        var packageInfo = await PackageInfo.fromPlatform();
        if (kIsWeb) {
          var value = await messaging.getToken();
          await AppAPI().create(
            "${EndPoints.notification}/notification_firebases",
            {
              "platform": "web",
              "firebase_code": value,
              "app_version": packageInfo.version,
              "app_build": packageInfo.buildNumber,
            },
            null,
          );
        } else {
          var isGranted = await Permission.notification.isGranted;
          if (!isGranted) {
            await Permission.notification.request().then((value) => null);
            isGranted = await Permission.notification.isGranted;
          }
          if (isGranted) {
            // FirebaseMessaging.instance.getNotificationSettings();
            // Permission.notification.request();
            await messaging.getToken().then((value) => AppAPI().create(
                  "${EndPoints.notification}/notification_firebases",
                  {
                    "platform": kIsWeb
                        ? "web"
                        : Platform.isAndroid
                            ? "android"
                            : Platform.isIOS
                                ? "ios"
                                : "other",
                    "firebase_code": value,
                    "app_version": packageInfo.version,
                    "app_build": packageInfo.buildNumber,
                  },
                  null,
                ));
          }
        }

        Navigator.of(context).pushReplacementNamed("/");
        return;
        // }
      } else {
        if (loginData.toString().contains("No active account")) {
          errorString = "کد تایید اشتباه است";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorString),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        setState(() {
          isVerifing = false;
        });
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("از اتصال دستگاه خود به اینترنت مطمئن شوید"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        isVerifing = false;
      });
    }
  }

  Timer? _timer;
  int? _secondsLeft;
  bool isUpdatingPrice = false;

  Future _startTimer() async {
    setState(() {
      _secondsLeft = ((Provider.of<AuthData>(context, listen: false).lastSmsSend - DateTime.now().millisecondsSinceEpoch) / 1000).truncate();
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsLeft = ((Provider.of<AuthData>(context, listen: false).lastSmsSend - DateTime.now().millisecondsSinceEpoch) / 1000).truncate();
      });
      if ((_secondsLeft ?? 0) < 1) {
        timer.cancel();
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var countdownString = _secondsLeft.toString();
    final PinTheme defaultPinTheme = PinTheme(
      width: kToolbarHeight,
      height: kToolbarHeight,
      textStyle: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    );

    final PinTheme submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white,
      ),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: kToolbarHeight),
              Column(children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.5),
                  padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'کد پیامک شده را وارد کنید:',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kToolbarHeight * 0.2),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
                          child: Pinput(
                            controller: _pinController,
                            defaultPinTheme: PinTheme(
                              width: kToolbarHeight,
                              height: kToolbarHeight,
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            autofocus: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            length: 5,
                            onCompleted: (String pin) async {
                              await verifyUser();
                              _pinController.clear();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: kToolbarHeight * 2),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.5),
                    child: Hero(
                      tag: "button",
                      child: InkWell(
                        onTap: verifyUser,
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              !isVerifing
                                  ? Text(
                                      "تایید",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        fontSize: 17,
                                      ),
                                    )
                                  : CupertinoActivityIndicator(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kToolbarHeight * 0.3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "کد تایید دریافت نشد؟",
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          reSendPass();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                          child: !isResending
                              ? Text(
                                  (_secondsLeft ?? 0) > 0 ? countdownString : "ارسال مجدد",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              : CupertinoActivityIndicator(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
