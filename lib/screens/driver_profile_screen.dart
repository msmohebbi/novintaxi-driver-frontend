import 'package:flutter/material.dart';
import 'package:transportationdriver/widgets/page_1.dart';
import 'package:transportationdriver/widgets/page_2.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          const Expanded(
            child: Page2(),
          ),
        ]),
      ),
    );
  }
}
