import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian/persian.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transportationdriver/models/transport_model.dart';
import 'package:transportationdriver/providers/driver_transport_data.dart';
import 'package:transportationdriver/providers/settings_data.dart';

class TransportCompact extends StatefulWidget {
  final AppTransport cTransport;

  const TransportCompact({super.key, required this.cTransport});

  @override
  State<TransportCompact> createState() => _TransportCompactState();
}

class _TransportCompactState extends State<TransportCompact> {
  @override
  Widget build(BuildContext context) {
    var rialFormat = intl.NumberFormat.currency(
      // customPattern: "###",
      locale: "fa_IR",
      decimalDigits: 0,
      symbol: "",
      customPattern: kIsWeb ? "####################" : null,
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kToolbarHeight * 0.3,
        // horizontal: kToolbarHeight * 0.2,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: kToolbarHeight * 0.2,
        horizontal: kToolbarHeight * 0.2,
      ),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(180),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              // vertical: kToolbarHeight * 0.3,
              horizontal: kToolbarHeight * 0.2,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'مسیر:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cTransport.ods?.isNotEmpty ?? false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cTransport.ods?.first.location.city ?? '',
                      ),
                    ],
                    if (widget.cTransport.ods?.isNotEmpty ?? false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      const Icon(Icons.arrow_circle_left_outlined),
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(widget.cTransport.ods?.last.location.city ?? ''),
                    ],
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Row(
                  children: [
                    const Text(
                      'نوع سفر:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: kToolbarHeight * 0.1,
                    ),
                    Text(
                      widget.cTransport.typeFa,
                    ),
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (widget.cTransport.dateSchedule != null) ...[
                  Row(
                    children: [
                      const Text(
                        'ساعت سفر:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cTransport.dateScheduleDateString!.toString(),
                      ),
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cTransport.dateScheduleTimeString
                                ?.format(context)
                                .withPersianNumbers() ??
                            '',
                      ),
                    ],
                  ),
                  const SizedBox(height: kToolbarHeight * 0.2),
                ],
                Row(
                  children: [
                    const Text(
                      'مدت زمان:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cTransport.ods?.isNotEmpty ?? false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(widget.cTransport.timeString),
                    ],
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Row(
                  children: [
                    const Text(
                      'مسافت:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cTransport.ods?.isNotEmpty ?? false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text('${widget.cTransport.meterKMString} کیلومتر'),
                    ],
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Row(
                  children: [
                    const Text(
                      'تعداد مسافر:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cTransport.ods?.isNotEmpty ?? false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cTransport.passengersCountString,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primary.withAlpha(180),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight * 0.2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'میزان درآمد:',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  width: kToolbarHeight * 0.1,
                ),
                Text(
                  '${rialFormat.format(widget.cTransport.price)} تومان',
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primary.withAlpha(180),
          ),
          const SizedBox(height: kToolbarHeight * 0.3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Theme.of(context).hintColor.withAlpha(100),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Provider.of<DriverTransportData>(context, listen: false)
                          .ignoreTransport(widget.cTransport);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: kToolbarHeight * 0.2,
                          horizontal: kToolbarHeight * 0.4),
                      child: Text('نادیده گرفتن'),
                    )),
              ),
              const SizedBox(width: kToolbarHeight * 0.3),
              Material(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      await showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: CupertinoAlertDialog(
                              title: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'شما در حال تایید و شروع سفر جدید هستید',
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 13,
                                      fontFamily: 'IRANYekan',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: kToolbarHeight * 0.1),
                                  Text(
                                    'آیا مطمئن هستید؟',
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 12,
                                      fontFamily: 'IRANYekan',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () async {
                                    Provider.of<DriverTransportData>(context,
                                            listen: false)
                                        .confirmTransport(widget.cTransport)
                                        .then((value) {
                                      Provider.of<SettingData>(context,
                                              listen: false)
                                          .setbnbIndex(1);
                                    });
                                    if (mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  icon: const Text(
                                    'تایید سفر',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      height: 2,
                                      fontSize: 13,
                                      fontFamily: 'IRANYekan',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Text(
                                    'بیخیال',
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 13,
                                      fontFamily: 'IRANYekan',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (mounted) {
                        Provider.of<SettingData>(context, listen: false)
                            .setbnbIndex(1);
                      }
                    },
                    child: Provider.of<DriverTransportData>(context)
                                .isConfirmingId ==
                            widget.cTransport.id
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.2,
                              horizontal: kToolbarHeight * 0.75,
                            ),
                            child: CupertinoActivityIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.2,
                              horizontal: kToolbarHeight * 0.4,
                            ),
                            child: Text(
                              'تایید سفر',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
              ),
            ],
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timeago.format(
                  DateTime.fromMillisecondsSinceEpoch(widget.cTransport.date),
                  locale: 'fa',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
