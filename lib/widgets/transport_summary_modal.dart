import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transport_data.dart';
import 'package:intl/intl.dart' as intl;

class TransportSummaryModal extends StatefulWidget {
  const TransportSummaryModal({super.key});

  @override
  State<TransportSummaryModal> createState() => _TransportSummaryModalState();
}

class _TransportSummaryModalState extends State<TransportSummaryModal> {
  // String? label;
  // String? timelabel;

  @override
  Widget build(BuildContext context) {
    var rialFormat = intl.NumberFormat.currency(
      // customPattern: "###",
      locale: "fa_IR",
      decimalDigits: 0,
      symbol: "",
      customPattern: kIsWeb ? "####################" : null,
    );
    // var sizee = MediaQuery.of(context).size;
    // var widthPix = sizee.width > sizee.height ? sizee.height : sizee.width;
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
                    Text(
                      "${rialFormat.format(Provider.of<TransportData>(context).cTransport?.price ?? 0)} تومان",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
                    Text(
                      "${rialFormat.format(((Provider.of<TransportData>(context).cTransport?.price ?? 0) * 0.15).toInt())} تومان",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: kToolbarHeight * 0.3),
          Padding(
            padding: const EdgeInsets.all(kToolbarHeight * 0.2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).hintColor.withAlpha(60),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: kToolbarHeight * 0.2),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "خلاصه سفر",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "مبدا: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            Provider.of<TransportData>(context, listen: false)
                                    .originLocation
                                    ?.desc ??
                                "",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "مقصد: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            Provider.of<TransportData>(context, listen: false)
                                    .targetLocation
                                    ?.desc ??
                                "",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "مسافت سفر: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            "${Provider.of<TransportData>(context).cTransport?.meterKMString ?? ""} کیلومتر",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "نوع سفر: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            (Provider.of<TransportData>(context, listen: false)
                                        .transportRoundTripTypes[
                                    Provider.of<TransportData>(context,
                                            listen: false)
                                        .cTransport!
                                        .back] ??
                                ""),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "نوع خودرو: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            (Provider.of<TransportData>(context, listen: false)
                                    .selectedVehicle
                                    ?.name ??
                                ""),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "سفر برای: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            (Provider.of<TransportData>(context, listen: false)
                                    .passengerTypes[Provider.of<TransportData>(
                                        context,
                                        listen: false)
                                    .cPassengerIsMe] ??
                                ""),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "تعداد مسافر: ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.1),
                          Text(
                            "${rialFormat.format(Provider.of<TransportData>(context, listen: false).cTransport!.adult)} بزرگسال و ${rialFormat.format(Provider.of<TransportData>(context, listen: false).cTransport!.child)} کودک",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.7),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kToolbarHeight * 0.2),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Material(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () async {
                                  Provider.of<TransportData>(context,
                                          listen: false)
                                      .setModalIndex(2);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: kTextTabBarHeight * 1.1,
                                  child: Text(
                                    "مرحله قبل",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.2),
                          Expanded(
                            flex: 3,
                            child: Material(
                              elevation: 0,
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () async {
                                  await Provider.of<TransportData>(context,
                                          listen: false)
                                      .searchTransportDriver();
                                  if (mounted) {
                                    if (Provider.of<TransportData>(
                                          context,
                                          listen: false,
                                        ).cTransport?.status ==
                                        'IN_PROGRESS') {
                                      Navigator.of(context)
                                          .pushNamed('/search');
                                    }
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: kTextTabBarHeight * 1.1,
                                  child: Provider.of<TransportData>(context)
                                          .isUpdatingTransport
                                      ? CupertinoActivityIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        )
                                      : Text(
                                          "جستجوی راننده",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
