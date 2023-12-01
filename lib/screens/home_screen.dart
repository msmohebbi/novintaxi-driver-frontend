import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor.withAlpha(100),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                    Text('درخواست های من'),
                  ],
                ),
              ),
              const SizedBox(height: kToolbarHeight * 0.2),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: kToolbarHeight * 0.3,
                  // horizontal: kToolbarHeight * 0.2,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: kToolbarHeight * 0.2,
                  horizontal: kToolbarHeight * 0.2,
                ),
                decoration: BoxDecoration(
                  // color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withAlpha(180),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        // vertical: kToolbarHeight * 0.3,
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'مبدا:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: kToolbarHeight * 0.2),
                          Row(
                            children: [
                              Text(
                                'مقصد:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: kToolbarHeight * 0.2),
                          Row(
                            children: [
                              Text(
                                'نوع سفر:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: kToolbarHeight * 0.2),
                          Row(
                            children: [
                              Text(
                                'ساعت سفر:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.2),
                    Divider(
                      height: 1,
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(180),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'میزان درآمد:',
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(180),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Theme.of(context).hintColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: kToolbarHeight * 0.2,
                                    horizontal: kToolbarHeight * 0.4),
                                child: Text('نادیده گرفتن'),
                              )),
                        ),
                        const SizedBox(width: kToolbarHeight * 0.3),
                        Material(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: kToolbarHeight * 0.2,
                                    horizontal: kToolbarHeight * 0.4),
                                child: Text(
                                  'تایید سفر',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
