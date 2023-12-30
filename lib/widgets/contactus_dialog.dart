import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persian/persian.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/settings_data.dart';

class AppContactUsDialog extends StatefulWidget {
  const AppContactUsDialog({super.key});

  @override
  State<AppContactUsDialog> createState() => _AppContactUsDialogState();
}

class _AppContactUsDialogState extends State<AppContactUsDialog> {
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
    if (widthPix > heightPix ||
        MediaQuery.of(context).orientation == Orientation.landscape) {
      widthPix = heightPix;
      isHorizontal = true;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: CupertinoAlertDialog(
        title: const Text(
          'تماس با ما',
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight * 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.fitWidth,
                          color: Provider.of<SettingData>(context).isDark
                              ? Colors.white
                              : null,
                          width: isHorizontal
                              ? widthPix * 0.2
                              : widthPixFixed * 0.3,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kToolbarHeight * 0.3,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          var url = Uri(
                            scheme: "https",
                            host: "instagram.com",
                            path: "novintaxi",
                          );
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "/novintaxi",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(FontAwesome.instagram),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          var url = Uri(
                            scheme: "https",
                            host: "t.me",
                            path: "novintaxi",
                          );
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "/novintaxi",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.telegram),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          var url =
                              Uri(scheme: "mailto", path: "info@novintaxi.com");
                          launchUrl(url);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "info@novintaxi.com",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.mail_rounded),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          var url = Uri(scheme: "tel", path: "09124625908");
                          launchUrl(url);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "09124625908".withPersianNumbers(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(FontAwesomeIcons.phone),
                          ],
                        ),
                      ),
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
    );
  }
}
