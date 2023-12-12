import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/settings_data.dart';

class AppAboutDialog extends StatefulWidget {
  const AppAboutDialog({super.key});

  @override
  State<AppAboutDialog> createState() => _AppAboutDialogState();
}

class _AppAboutDialogState extends State<AppAboutDialog> {
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
      log(version);
    });
  }

  String version = "";
  String buildNumber = "";

  @override
  Widget build(BuildContext context) {
    var widthPixFixed = MediaQuery.of(context).size.width;
    var heightPixFixed = MediaQuery.of(context).size.height;
    var widthPix = widthPixFixed;
    var heightPix = heightPixFixed;
    bool isHorizontal = false;
    int fontDelta = 0;
    if (widthPix > heightPix ||
        MediaQuery.of(context).orientation == Orientation.landscape) {
      fontDelta = 1;
      widthPix = heightPix;
      isHorizontal = true;
    }

    return Material(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fitWidth,
                    color: Provider.of<SettingData>(context).isDark
                        ? Colors.white
                        : null,
                    width: isHorizontal ? widthPix * 0.3 : widthPixFixed * 0.5,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "مدیر مسوول :  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decorationStyle: TextDecorationStyle.dashed,
                            fontSize: fontDelta + 12,
                            color: Theme.of(context).primaryColor),
                      ),
                      InkWell(
                        onTap: () {
                          // var url = Uri(
                          //   scheme: "https",
                          //   host: "www.instagram.com",
                          //   path: "mohammad._.moosavi/",
                          // );
                          // launchUrl(
                          //   url,
                          //   mode: LaunchMode.externalApplication,
                          // );
                        },
                        child: Text(
                          "سید مهدی علایی",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // decorationStyle: TextDecorationStyle.dashed,
                              decoration: TextDecoration.underline,
                              fontSize: fontDelta + 12,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "مدیر برنامه نویسی :  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decorationStyle: TextDecorationStyle.dashed,
                            fontSize: fontDelta + 12,
                            color: Theme.of(context).primaryColor),
                      ),
                      InkWell(
                        onTap: () {
                          var url = Uri(
                            scheme: "https",
                            host: "www.linkedin.com",
                            path: "in/msmohebbi/",
                          );
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Text(
                          "محمد سعید محبی",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // decorationStyle: TextDecorationStyle.dashed,
                              decoration: TextDecoration.underline,
                              fontSize: fontDelta + 12,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "برنامه نویسی سرور :  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decorationStyle: TextDecorationStyle.dashed,
                            fontSize: fontDelta + 12,
                            color: Theme.of(context).primaryColor),
                      ),
                      InkWell(
                        onTap: () {
                          // var url = Uri(
                          //   scheme: "https",
                          //   host: "www.linkedin.com",
                          //   path: "in/msmohebbi/",
                          // );
                          // launchUrl(
                          //   url,
                          //   mode: LaunchMode.externalApplication,
                          // );
                        },
                        child: Text(
                          "وحید کامرانی",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // decorationStyle: TextDecorationStyle.dashed,
                              decoration: TextDecoration.underline,
                              fontSize: fontDelta + 12,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "طراحی رابط کاربری :  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decorationStyle: TextDecorationStyle.dashed,
                            fontSize: fontDelta + 12,
                            color: Theme.of(context).primaryColor),
                      ),
                      InkWell(
                        onTap: () {
                          var url = Uri(
                            scheme: "https",
                            host: "www.instagram.com",
                            path: "aniseh.v/",
                          );
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Text(
                          "انیسه ولی زاده",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // decorationStyle: TextDecorationStyle.dashed,
                              decoration: TextDecoration.underline,
                              fontSize: fontDelta + 12,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "ورژن $version",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: fontDelta + 12,
                        color: Theme.of(context).primaryColor),
                  ),
                  if (isHorizontal && kIsWeb) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/download");
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Theme.of(context).colorScheme.secondary,
                                child: const Text(
                                  "دانلود اپلیکیشن",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
