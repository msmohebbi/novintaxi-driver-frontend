import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transport_data.dart';
import 'package:intl/intl.dart' as intl;

class TransportVehicleModal extends StatefulWidget {
  const TransportVehicleModal({super.key});

  @override
  State<TransportVehicleModal> createState() => _TransportVehicleModalState();
}

class _TransportVehicleModalState extends State<TransportVehicleModal> {
  @override
  Widget build(BuildContext context) {
    var isSelectingVehicle =
        Provider.of<TransportData>(context).isUpdatingTransport;
    var rialFormat = intl.NumberFormat.currency(
      // customPattern: "###",
      locale: "fa_IR",
      decimalDigits: 0,
      symbol: "",
      customPattern: kIsWeb ? "####################" : null,
    );
    var sizee = MediaQuery.of(context).size;
    var widthPix = sizee.width > sizee.height ? sizee.height : sizee.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: kToolbarHeight * 0.5,
              vertical: kToolbarHeight * 0.2,
            ),
            padding: const EdgeInsets.all(kToolbarHeight * 0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "مبلغ کل پرداختی",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.2),
                    !isSelectingVehicle
                        ? Text(
                            "${rialFormat.format(Provider.of<TransportData>(context).cTransport?.price ?? 0)} تومان",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        : CupertinoActivityIndicator(
                            radius: 12,
                            color: Theme.of(context).hintColor,
                          ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: [
                    Text(
                      "مبلغ پیش پرداخت",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.2),
                    !isSelectingVehicle
                        ? Text(
                            "${rialFormat.format(((Provider.of<TransportData>(context).cTransport?.price ?? 0) * 0.15).toInt())} تومان",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        : CupertinoActivityIndicator(
                            radius: 12,
                            color: Theme.of(context).hintColor,
                          ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...Provider.of<TransportData>(context).allVehicles.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(kToolbarHeight * 0.2),
                        child: Column(
                          children: [
                            Image.network(
                              e.image,
                              width: kToolbarHeight * 1.5,
                            ),
                            const SizedBox(
                              height: kToolbarHeight * 0.2,
                            ),
                            Text(
                              e.name,
                              style: const TextStyle(fontSize: 13),
                            ),
                            // SizedBox(
                            //   height: kToolbarHeight * 0.1,
                            // ),
                            Radio(
                                value: e,
                                groupValue: Provider.of<TransportData>(context)
                                    .selectedVehicle,
                                onChanged: (newVehicle) {
                                  Provider.of<TransportData>(context,
                                          listen: false)
                                      .setSelectedVehicle(newVehicle!);
                                })
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
          Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () async {
                Provider.of<TransportData>(context, listen: false)
                    .setModalIndex(1);
              },
              child: Container(
                width: widthPix * 0.5,
                alignment: Alignment.center,
                height: kTextTabBarHeight * 1.1,
                child: isSelectingVehicle
                    ? CupertinoActivityIndicator(
                        color: Theme.of(context).hintColor,
                      )
                    : Text(
                        "تایید خودرو",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
