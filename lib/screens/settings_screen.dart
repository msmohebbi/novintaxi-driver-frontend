import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
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
          child: Material(
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withAlpha(180),
                  ),
                ),
                child: const Column(
                  children: [
                    Padding(
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
                    Divider(height: 1),
                    Padding(
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
                    Divider(height: 1),
                    Padding(
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
                  ],
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
            color: Theme.of(context).hintColor.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('حالت شب'),
                          CupertinoSwitch(
                              activeColor:
                                  Theme.of(context).colorScheme.secondary,
                              value: Provider.of<SettingData>(context).isDark,
                              onChanged: (_) {
                                Provider.of<SettingData>(context, listen: false)
                                    .changeIsDark();
                              }),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    const Padding(
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
                    const Divider(height: 1),
                    const Padding(
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
                    const Divider(height: 1),
                    const Padding(
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
                  ],
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
            color: Theme.of(context).hintColor.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).hintColor.withAlpha(100),
                  ),
                ),
                child: const Column(
                  children: [
                    Padding(
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
                    Divider(height: 1),
                    Padding(
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
                    Divider(height: 1),
                    Padding(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
