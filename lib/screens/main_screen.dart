import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/providers/notification_data.dart';
import 'package:novintaxidriver/screens/history_screen.dart';

import '../providers/settings_data.dart';
import 'home_screen.dart';

import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  var homeScreen = const HomeScreen();
  List<Widget> screensList = [
    const HomeScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationData>(context, listen: false);
    int bnbIndex = Provider.of<SettingData>(context).bnbIndex;
    var widthPixFixed = MediaQuery.of(context).size.width;
    var heightPixFixed = MediaQuery.of(context).size.height;
    var widthPix = widthPixFixed;
    // int fontDelta = 0;
    var heightPix = heightPixFixed;
    // bool isHorizontal = false;
    if (widthPix > heightPix || MediaQuery.of(context).orientation == Orientation.landscape) {
      // fontDelta = 1;
      widthPix = heightPix;
      // isHorizontal = true;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        // padding: MediaQuery.of(context).padding,
        child: SafeArea(
          maintainBottomViewPadding: true,
          bottom: true,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                "حمل و نقل بین شهری",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: Padding(
                padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                child: Image.asset(
                  'assets/images/logo.png',
                  color: Theme.of(context).primaryColor,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            body: IndexedStack(
              index: bnbIndex,
              children: screensList,
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: BottomNavigationBar(
                backgroundColor: Theme.of(context).cardColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: bnbIndex,
                onTap: (newIndex) {
                  Provider.of<SettingData>(context, listen: false).setbnbIndex(newIndex);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.house),
                    activeIcon: Icon(
                      CupertinoIcons.house_fill,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'خانه',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.square_list),
                    activeIcon: Icon(
                      CupertinoIcons.square_list_fill,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'تاریخچه',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.settings),
                    activeIcon: Icon(
                      CupertinoIcons.settings_solid,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'تنظیمات',
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
