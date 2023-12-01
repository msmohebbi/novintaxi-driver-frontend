import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_transport_data.dart';
import 'package:transportationdriver/widgets/transport_compact.dart';

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
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await Provider.of<DriverTransportData>(context, listen: false)
              .getTransports();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight * 0.3),
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
              ...Provider.of<DriverTransportData>(context).allTransports.map(
                (e) {
                  return TransportCompact(cTransport: e);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
