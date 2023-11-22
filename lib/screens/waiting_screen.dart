import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.8,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(500),
                topRight: Radius.circular(500),
              ),
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.5,
                        vertical: kTextTabBarHeight,
                      ),
                      child: Image.asset(
                        'assets/images/waitingprofile.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: kToolbarHeight * 0.4,
                    ),
                    Text(
                      'احراز هویت و مدارک شما، در دست بررسی می باشد',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    const SizedBox(
                      height: kToolbarHeight * 0.4,
                    ),
                    Text(
                      'از شکیبایی شما سپاس گذاریم',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    const SizedBox(
                      height: kToolbarHeight * 0.4,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: kToolbarHeight * 0.2,
                            horizontal: kToolbarHeight * 0.5,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ویرایش اطلاعات '),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
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
          ),
        ),
      ),
    );
  }
}
