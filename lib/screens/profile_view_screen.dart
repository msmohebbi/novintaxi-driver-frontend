import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/page_0.dart';
import 'package:transportationdriver/widgets/page_1.dart';

class ProfileViewScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<DriverData>(context, listen: false)
        .setDriverFieldsDefaultValue();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'اطلاعات کاربری',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Page0(
                isScreen: true,
              ),
              Page1(
                isScreen: true,
              ),
              SizedBox(height: kToolbarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
