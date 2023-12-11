import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/page_3.dart';
import 'package:transportationdriver/widgets/page_4.dart';

class VehicleViewScreen extends StatefulWidget {
  static const routeName = '/vehicle';
  const VehicleViewScreen({super.key});

  @override
  State<VehicleViewScreen> createState() => _VehicleViewScreenState();
}

class _VehicleViewScreenState extends State<VehicleViewScreen> {
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
            'اطلاعات خودرو',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Page3(
                isScreen: true,
              ),
              Page4(
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
