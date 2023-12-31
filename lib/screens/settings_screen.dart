import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:novintaxidriver/providers/profile_data.dart';
import 'package:novintaxidriver/widgets/contactus_dialog.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/providers/auth_data.dart';
import 'package:novintaxidriver/providers/driver_data.dart';
import 'package:novintaxidriver/screens/license_view_screen.dart';
import 'package:novintaxidriver/screens/profile_view_screen.dart';
import 'package:novintaxidriver/screens/revenue_screen.dart';
import 'package:novintaxidriver/screens/vehicle_view_screen.dart';
import 'package:novintaxidriver/widgets/about_dialog.dart';
import 'package:persian/persian.dart';

import '../providers/settings_data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
    var cDriver = Provider.of<DriverData>(context).cDriver;
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: kToolbarHeight * 0.3),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: kToolbarHeight * 0.5,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: kToolbarHeight * 0.2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withAlpha(180),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تنظیمات کاربری'),
            ],
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kToolbarHeight * 0.2,
          ),
          child: Material(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Navigator.of(context).pushNamed(RevenueScreen.routeName);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withAlpha(180),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kToolbarHeight * 0.2,
                    horizontal: kToolbarHeight * 0.4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (cDriver?.personalImage != null) ...[
                        ClipOval(
                          child: SizedBox(
                            width: kToolbarHeight * 0.6,
                            height: kToolbarHeight * 0.6,
                            child: CachedNetworkImage(
                              imageUrl: cDriver!.personalImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: kToolbarHeight * 0.2),
                      ],
                      Column(
                        children: [
                          Text(
                            Provider.of<DriverData>(context).cDriver?.name ??
                                '',
                          ),
                          if (Provider.of<ProfileData>(context)
                                  .cUserProfile
                                  ?.username !=
                              null) ...[
                            const SizedBox(height: kToolbarHeight * 0.1),
                            Text(
                              "(${Provider.of<ProfileData>(context).cUserProfile!.username.withPersianNumbers()})",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(150),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const Spacer(),
                      if (Provider.of<DriverData>(context).cDriver?.rate !=
                          null) ...[
                        const Spacer(),
                        SizedBox(
                          width: kToolbarHeight * 1.3,
                          child: FittedBox(
                            child: RatingBarIndicator(
                              rating: cDriver!.rate!,
                              itemBuilder: (context, index) => Listener(
                                onPointerDown: (_) {},
                                child: Icon(
                                  cDriver.rate! < index + 1
                                      ? CupertinoIcons.star
                                      : CupertinoIcons.star_fill,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              itemCount: 5,
                              itemSize: kToolbarHeight * 0.4,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kToolbarHeight * 0.2,
          ),
          child: Material(
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.of(context).pushNamed(RevenueScreen.routeName);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withAlpha(180),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kToolbarHeight * 0.3,
                    horizontal: kToolbarHeight * 0.4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('میزان درآمد'),
                      Icon(
                        CupertinoIcons.forward,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kToolbarHeight * 0.2,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(180),
              ),
            ),
            child: Column(
              children: [
                Material(
                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProfileViewScreen.routeName);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('اطلاعات کاربری'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(VehicleViewScreen.routeName);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('اطلاعات خودرو'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(LicenseViewScreen.routeName);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('اطلاعات گواهینامه'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kToolbarHeight * 0.2,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).hintColor.withAlpha(100),
              ),
            ),
            child: Column(
              children: [
                Material(
                  color: Theme.of(context).hintColor.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.2,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('حالت شب'),
                          CupertinoSwitch(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: Provider.of<SettingData>(context).isDark,
                              onChanged: (_) {
                                Provider.of<SettingData>(context, listen: false)
                                    .changeIsDark();
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).hintColor.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/faqs');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('سوالات متداول'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).hintColor.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/support');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ارتباط با پشتیبانی'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).hintColor.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    onTap: () {
                      showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return const AppContactUsDialog();
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('تماس با ما'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kToolbarHeight * 0.2,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).hintColor.withAlpha(100),
              ),
            ),
            child: Column(
              children: [
                Material(
                  color: Theme.of(context).hintColor.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('قوانین و مقررات'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).hintColor.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return const AppAboutDialog();
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('درباره ما'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Material(
                  color: Theme.of(context).colorScheme.error.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    onTap: () {
                      showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: CupertinoAlertDialog(
                              title: const Text(
                                'شما درحال خروج از حساب کاربری خود هستید، \n آیا مطمئن هستید',
                                style: TextStyle(
                                  height: 2,
                                  fontSize: 13,
                                  fontFamily: 'IRANYekan',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () async {
                                    await Provider.of<AuthData>(context,
                                            listen: false)
                                        .signOut();

                                    if (mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('خروج از حساب'),
                          Icon(
                            CupertinoIcons.forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight),
      ],
    );
  }
}
