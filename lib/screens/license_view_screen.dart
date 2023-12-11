import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/page_2.dart';

class LicenseViewScreen extends StatefulWidget {
  static const routeName = '/license';
  const LicenseViewScreen({super.key});

  @override
  State<LicenseViewScreen> createState() => _LicenseViewScreenState();
}

class _LicenseViewScreenState extends State<LicenseViewScreen> {
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
            'اطلاعات گواهینامه',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Page2(
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
