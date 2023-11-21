import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_data.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight * 0.5),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1000),
                topRight: Radius.circular(1000),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kToolbarHeight,
                    horizontal: kToolbarHeight * 0.6,
                  ),
                  child: Image.asset(
                    'assets/images/introtext.png',
                  ),
                ),
                Image.asset(
                  'assets/images/intro.png',
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.5),
          child: Hero(
            tag: "button",
            child: InkWell(
              onTap: () {
                Provider.of<SettingData>(context, listen: false)
                    .setauthPageIndex(1);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(kToolbarHeight * 0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'بعدی',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight * 0.5),
      ],
    );
  }
}
