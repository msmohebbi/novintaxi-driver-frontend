import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_transport_data.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timeago/timeago.dart' as timeago;

class RevenueScreen extends StatefulWidget {
  static const routeName = '/revenue';
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  @override
  Widget build(BuildContext context) {
    var rialFormat = intl.NumberFormat.currency(
      // customPattern: "###",
      locale: "fa_IR",
      decimalDigits: 0,
      symbol: "",
      customPattern: kIsWeb ? "####################" : null,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'مدیریت درآمد',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: ListView(children: [
          ...Provider.of<DriverTransportData>(context).donedriverTransports.map(
            (e) {
              var revenue = e.transport.price - e.transport.commision;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kToolbarHeight * 0.1,
                  horizontal: kToolbarHeight * 0.2,
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(context).hintColor.withAlpha(60),
                      )),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.1),
                    child: Text(
                      '${rialFormat.format(revenue)} ریال',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  subtitle: Text(
                    '${e.transport.ods?.firstOrNull?.location.city ?? ''}  --->  ${e.transport.ods?.lastOrNull?.location.city ?? ''}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    timeago.format(
                      DateTime.fromMillisecondsSinceEpoch(e.dateEnded!),
                      locale: 'fa',
                    ),
                  ),
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
