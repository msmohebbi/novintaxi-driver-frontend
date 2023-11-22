import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../providers/settings_data.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    // double sizedBoxWidth = 0.5;
    var widthPixFixed = MediaQuery.of(context).size.width;
    var heightPixFixed = MediaQuery.of(context).size.height;
    var widthPix = widthPixFixed;
    // int fontDelta = 0;
    var heightPix = heightPixFixed;
    // bool isHorizontal = false;
    if (widthPix > heightPix ||
        MediaQuery.of(context).orientation == Orientation.landscape) {
      // fontDelta = 1;
      widthPix = heightPix;
      // isHorizontal = true;
    } // var csetting = Provider.of<SettingData>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, right: 15),
          child: Row(
            children: [
              Icon(
                Entypo.flash,
                color: Theme.of(context).hintColor,
              ),
              const SizedBox(width: 10),
              Text(
                "دسترسی سریع",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
          ),
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("/chatscreen"),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Elusive.headphones,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ارتباط با پشتیبانی",
                      style: TextStyle(
                          wordSpacing: -3,
                          fontSize: 12,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed("/studentinfoscreen"),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesome5.store,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "اطلاعات داتشجویی",
                      style: TextStyle(
                          wordSpacing: -3,
                          fontSize: 12,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Elusive.basket,
                    size: 25,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "تاریخچه خرید",
                    style: TextStyle(
                        wordSpacing: -3,
                        fontSize: 12,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Row(
        //     children: [
        //       Icon(
        //         CupertinoIcons.gear,
        //         color: Theme.of(context).hintColor,
        //       ),
        //       SizedBox(width: 10),
        //       Text(
        //         "پنل کاربری",
        //         style: TextStyle(fontSize: 13),
        //       ),
        //     ],
        //   ),
        // ),
        // ListTile(
        //   minVerticalPadding: 0,
        //   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        //   tileColor: Theme.of(context).cardColor.withAlpha(100),
        //   title: Text(
        //     "گواهی ها",
        //     style: TextStyle(fontSize: 14),
        //   ),
        //   subtitle: Text(
        //     "مدیریت گواهی های اعطایی به شما",
        //     style: TextStyle(fontSize: 12),
        //   ),
        //   leading: CircleAvatar(
        //     radius: 25,
        //     backgroundColor:
        //         Theme.of(context).colorScheme.secondary.withAlpha(45),
        //     child: Icon(
        //       FontAwesome5.certificate,
        //       size: 20,
        //       color: Theme.of(context).colorScheme.secondary,
        //     ),
        //   ),
        // ),
        // ListTile(
        //   minVerticalPadding: 0,
        //   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        //   // tileColor: Theme.of(context).cardColor.withAlpha(100),
        //   title: Text(
        //     "تاریخچه خرید",
        //     style: TextStyle(fontSize: 14),
        //   ),
        //   subtitle: Text(
        //     "محصولات خریداری شده شما",
        //     style: TextStyle(fontSize: 12),
        //   ),
        //   leading: CircleAvatar(
        //     radius: 25,
        //     backgroundColor:
        //         Theme.of(context).colorScheme.secondary.withAlpha(45),
        //     child: Icon(
        //       FontAwesome5.shopping_basket,
        //       size: 20,
        //       color: Theme.of(context).colorScheme.secondary,
        //     ),
        //   ),
        // ),
        // ListTile(
        //   minVerticalPadding: 0,
        //   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        //   tileColor: Theme.of(context).cardColor.withAlpha(100),
        //   title: Text(
        //     "تراکنش های مالی",
        //     style: TextStyle(fontSize: 14),
        //   ),
        //   subtitle: Text(
        //     "مدیریت پرداخت های حساب شما",
        //     style: TextStyle(fontSize: 12),
        //   ),
        //   leading: CircleAvatar(
        //     radius: 25,
        //     backgroundColor:
        //         Theme.of(context).colorScheme.secondary.withAlpha(45),
        //     child: Icon(
        //       Icons.receipt_long,
        //       size: 20,
        //       color: Theme.of(context).colorScheme.secondary,
        //     ),
        //   ),
        // ),
        ListTile(
          onTap: () {
            // Provider.of<FuncData>(context, listen: false)
            //     .showNotificationModal(ProfileModal(), context);
          },
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "حساب کاربری",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت اطلاعاتی که به شما میفرستیم",
          //   style: TextStyle(fontSize: 12),
          // ),

          trailing: const Icon(CupertinoIcons.forward),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              CupertinoIcons.person_alt_circle_fill,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListTile(
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "اعلان ها",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت اطلاعاتی که به شما میفرستیم",
          //   style: TextStyle(fontSize: 12),
          // ),

          trailing: const Icon(CupertinoIcons.forward),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              FontAwesome5.bell,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListTile(
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "حریم خصوصی",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت امنیت حساب کاربری و اپلیکیشن",
          //   style: TextStyle(fontSize: 12),
          // ),
          trailing: const Icon(CupertinoIcons.forward),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              FontAwesome5.shield_alt,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          height: 3,
        ),
        ListTile(
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "حالت شب",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت امنیت حساب کاربری و اپلیکیشن",
          //   style: TextStyle(fontSize: 12),
          // ),
          // trailing: GestureDetector(
          //   onTap: () {
          //     Provider.of<SettingData>(context, listen: false)
          //         .changeIsDark();
          //   },
          //   child: Provider.of<SettingData>(context).isDark
          //       ? Transform.rotate(
          //           angle: pi / 8, child: Icon(Icons.mode_night_rounded))
          //       : Icon(Icons.wb_sunny),
          // ),
          trailing: CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.secondary,
              value: Provider.of<SettingData>(context).isDark,
              onChanged: (_) {
                Provider.of<SettingData>(context, listen: false).changeIsDark();
              }),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              FontAwesome5.moon,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListTile(
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "سوالات متداول",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت امنیت حساب کاربری و اپلیکیشن",
          //   style: TextStyle(fontSize: 12),
          // ),
          trailing: const Icon(CupertinoIcons.forward),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              FontAwesome5.question,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListTile(
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "تماس با ما",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت امنیت حساب کاربری و اپلیکیشن",
          //   style: TextStyle(fontSize: 12),
          // ),
          trailing: const Icon(CupertinoIcons.forward),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              FontAwesome5.phone,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListTile(
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          // tileColor: Theme.of(context).cardColor.withAlpha(100),
          title: Text(
            "درباره ما",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // subtitle: Text(
          //   "مدیریت امنیت حساب کاربری و اپلیکیشن",
          //   style: TextStyle(fontSize: 12),
          // ),
          trailing: const Icon(CupertinoIcons.forward),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withAlpha(45),
            child: Icon(
              FontAwesome5.info,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
