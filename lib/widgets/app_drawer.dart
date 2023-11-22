import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_data.dart';
import '../providers/settings_data.dart';

import '../providers/auth_data.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kToolbarHeight * 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: kToolbarHeight * 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  Provider.of<ProfileData>(context).cUserProfile?.name ?? '',
                ),
                leading: ClipOval(
                  child: Container(
                    height: kToolbarHeight * 0.7,
                    width: kToolbarHeight * 0.7,
                    color: Theme.of(context).hintColor.withAlpha(60),
                    child:
                        Provider.of<ProfileData>(context).cUserProfile?.image !=
                                null
                            ? CachedNetworkImage(
                                imageUrl: Provider.of<ProfileData>(context)
                                    .cUserProfile!
                                    .image!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                CupertinoIcons.person_fill,
                                size: 24,
                              ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              child: ListTile(
                onTap: () {},
                tileColor: Theme.of(context).colorScheme.primary.withAlpha(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: const Text(
                  "موجودی کیف پول",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              child: ListTile(
                dense: true,
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ),
                title: const Text(
                  "اعلانات",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: Badge(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              child: ListTile(
                dense: true,
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ),
                title: const Text(
                  "حالت شب",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: CupertinoSwitch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: Provider.of<SettingData>(context).isDark,
                    onChanged: (_) {
                      Provider.of<SettingData>(context, listen: false)
                          .changeIsDark();
                    }),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  )),
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    minVerticalPadding: 0,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "اطلاعات کاربری",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor.withAlpha(50)),
                  ListTile(
                    dense: true,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "تاریخچه سفرها",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor.withAlpha(50)),
                  ListTile(
                    dense: true,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "آدرس های منتخب",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  )),
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    minVerticalPadding: 0,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "قوانین و شرایط",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor.withAlpha(50)),
                  ListTile(
                    dense: true,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "ارتباط با پشتیبانی",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor.withAlpha(50)),
                  ListTile(
                    dense: true,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "تماس با ما",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor.withAlpha(50)),
                  ListTile(
                    dense: true,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    title: const Text(
                      "درباره ما",
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kToolbarHeight * 0.2,
                vertical: kToolbarHeight * 0.1,
              ),
              child: ListTile(
                dense: true,
                onTap: () {
                  Provider.of<AuthData>(context, listen: false).signOut();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  ),
                ),
                title: const Text(
                  "خروج از حساب",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }
}
