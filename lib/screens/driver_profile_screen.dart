import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/page_0.dart';
import 'package:transportationdriver/widgets/page_1.dart';
import 'package:transportationdriver/widgets/page_2.dart';
import 'package:transportationdriver/widgets/page_3.dart';
import 'package:transportationdriver/widgets/page_4.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  var pagesList = [
    const Page0(),
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];
  @override
  Widget build(BuildContext context) {
    var currentIndex = Provider.of<DriverData>(context).pageIndex;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: pagesList[currentIndex],
            ),
          ],
        ),
      ),
    );
  }
}
