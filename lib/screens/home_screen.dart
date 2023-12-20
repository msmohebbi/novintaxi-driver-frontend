import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/providers/driver_data.dart';
import 'package:novintaxidriver/providers/driver_transport_data.dart';
import 'package:novintaxidriver/widgets/transport_compact.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kToolbarHeight * 0.2,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(180),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kToolbarHeight * 0.2,
                      horizontal: kToolbarHeight * 0.4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'در حال استراحت',
                        ),
                        CupertinoSwitch(
                          value: Provider.of<DriverData>(context)
                                  .cDriver
                                  ?.isAvailable ??
                              false,
                          onChanged: (_) async {
                            await Provider.of<DriverData>(context,
                                    listen: false)
                                .changeIsAvailabe();
                            if (mounted) {
                              if (Provider.of<DriverData>(context,
                                          listen: false)
                                      .isChangeAvailable ==
                                  true) {
                                Provider.of<DriverTransportData>(context,
                                        listen: false)
                                    .getTransports();
                              }
                            }
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                          trackColor: Theme.of(context).cardColor,
                          thumbColor:
                              Provider.of<DriverData>(context).isChangeAvailable
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background,
                        ),
                        const Text(
                          'روی خط',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: kToolbarHeight * 0.2),
              if (Provider.of<DriverData>(context).cDriver?.isAvailable ==
                  true) ...[
                if (Provider.of<DriverTransportData>(context)
                    .allTransports
                    .isEmpty) ...[
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height - kToolbarHeight * 4,
                    child: const Center(
                      child: Text(
                        'در حال حاضر سفری برای شما درخواست نشده است!',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ] else ...[
                  ...Provider.of<DriverTransportData>(context)
                      .allTransports
                      .map(
                    (e) {
                      return TransportCompact(cTransport: e);
                    },
                  ),
                ]
              ] else ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const Center(
                    child: Text(
                      'در حال حاضر در حال استراحت می باشید!',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
