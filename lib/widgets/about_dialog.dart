import 'dart:developer';

import 'package:flutter/cupertino.dart';
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: CupertinoAlertDialog(
        title: const Text(
          'درباره ما',
          style: TextStyle(
            height: 2,
            fontSize: 14,
            fontFamily: 'IRANYekan',
            fontWeight: FontWeight.normal,
          ),
        ),
        content: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: kToolbarHeight * 0.2,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.fitWidth,
                        color: Provider.of<SettingData>(context).isDark
                            ? Colors.white
                            : null,
                        width:
                            isHorizontal ? widthPix * 0.2 : widthPixFixed * 0.3,
                      ),
                      const SizedBox(
                        height: kToolbarHeight * 0.3,
                      ),
                      Text(
                        "نوین تاکسی به پشتوانه چندین سال تجربه و کار به صورت عملی و لمس موضوعات مربوط به سفرهای بین شهری بر آن آمدیم برای خدمات در حوزه بین خودروهای بین شهری را با امکانات و قابلیت‌های بی‌شماری برای مسافران عزیز فراهم کنیم وب اپلیکیشن نوین تاکسی با افتخار اعلام می‌دارد با وجود رانندگان حرفه‌ای رانندگان قابلیت رزرو قابلیت صدور فاکتور قابلیت انتخاب راننده قابلیت انتخاب نوع خودرو از سمند و پرشیا تا شاسی و بسیاری دیگر امکانات  …",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decorationStyle: TextDecorationStyle.dashed,
                            fontSize: fontDelta + 11,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: kToolbarHeight * 0.2,
                      ),
                      Wrap(
                        children: [
                          Text(
                            "مدیر مسئول :  ",
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
                        height: kToolbarHeight * 0.15,
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
                        height: kToolbarHeight * 0.15,
                      ),
                      Wrap(
                        children: [
                          Text(
                            "برنامه نویسی بک اند :  ",
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
                                path: "in/vahid-kamrani-7379b0212/",
                              );
                              launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
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
                        height: kToolbarHeight * 0.15,
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
                        height: kToolbarHeight * 0.4,
                      ),
                      Text(
                        "ورژن $version",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontDelta + 12,
                            color: Theme.of(context).primaryColor),
                      ),
                      // const SizedBox(
                      //   height: kToolbarHeight * 0.3,
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
