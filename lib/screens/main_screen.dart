import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_data.dart';
import 'home_screen.dart';

import 'user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<AllOrdersData>(context, listen: false);
  }

  var homeScreen = const HomeScreen();
  List<Widget> screensList = [
    const HomeScreen(),
    Container(),
    Container(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int bnbIndex = Provider.of<SettingData>(context).bnbIndex;
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
              )),
        ),
      ),
    );
  }
}
