import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import '../providers/transport_data.dart';
import 'package:intl/intl.dart' as intl;

class TransportOptionModal extends StatefulWidget {
  const TransportOptionModal({super.key});

  @override
  State<TransportOptionModal> createState() => _TransportOptionModalState();
}

class _TransportOptionModalState extends State<TransportOptionModal> {
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
      child: Container(
        margin: const EdgeInsets.all(kToolbarHeight * 0.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).hintColor.withAlpha(60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight * 0.2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: Row(
                children: [
                  Text('نوع سفر:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: Row(
                children: [
                  ...Provider.of<TransportData>(context)
                      .transportRoundTripTypes
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kToolbarHeight * 0.2),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Provider.of<TransportData>(context,
                                        listen: false)
                                    .setcTransportRoundTrip(e.key);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withAlpha(60),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                      visualDensity: VisualDensity.compact,
                                      value: e.key,
                                      groupValue:
                                          Provider.of<TransportData>(context)
                                              .cTransport!
                                              .back,
                                      onChanged: (_) {
                                        Provider.of<TransportData>(context,
                                                listen: false)
                                            .setcTransportRoundTrip(e.key);
                                      },
                                    ),
                                    Text(
                                      e.value,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: kToolbarHeight * 0.2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: Row(
                children: [
                  Text('زمان سفر:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: Row(
                children: [
                  ...Provider.of<TransportData>(context)
                      .transportTimeTypes
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kToolbarHeight * 0.2),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Provider.of<TransportData>(context,
                                        listen: false)
                                    .setcTransportTime(e.key);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withAlpha(60),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                      visualDensity: VisualDensity.compact,
                                      value: e.key,
                                      groupValue:
                                          Provider.of<TransportData>(context)
                                              .cTransport!
                                              .type,
                                      onChanged: (_) {
                                        Provider.of<TransportData>(context,
                                                listen: false)
                                            .setcTransportTime(e.key);
                                      },
                                    ),
                                    Text(
                                      e.value,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: kToolbarHeight * 0.2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
            if (Provider.of<TransportData>(context).cTransport?.type ==
                'scheduled') ...[
              const SizedBox(height: kToolbarHeight * 0.3),
              Divider(
                height: 3,
                color: Theme.of(context).hintColor.withAlpha(60),
              ),
              const SizedBox(height: kToolbarHeight * 0.2),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                child: Row(
                  children: [
                    Text('تاریخ و زمان سفر رفت:'),
                  ],
                ),
              ),
              const SizedBox(height: kToolbarHeight * 0.2),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight * 0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("تاریخ:"),
                    const SizedBox(width: kToolbarHeight * 0.2),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.now(),
                          firstDate: Jalali.now(),
                          lastDate: Jalali.now().addDays(7),
                          builder: (context, child) {
                            return Theme(data: ThemeData(), child: child!);
                          },
                        );
                        if (picked != null && context.mounted) {
                          Provider.of<TransportData>(context, listen: false)
                              .setcTransportDateScheduledDate(
                                  picked.toDateTime());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                        child: Text(Provider.of<TransportData>(context)
                                .cTransport
                                ?.dateScheduleDateString ??
                            "انتخاب کنید"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight * 0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("زمان:"),
                    const SizedBox(width: kToolbarHeight * 0.2),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        var picked = await showTimePicker(
                          helpText: "انتخاب زمان",
                          cancelText: 'انصراف',
                          confirmText: 'تایید',
                          hourLabelText: 'ساعت',
                          minuteLabelText: 'دقیقه',
                          builder: (context, child) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child:
                                  Theme(data: Theme.of(context), child: child!),
                            );
                          },
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null && context.mounted) {
                          Provider.of<TransportData>(context, listen: false)
                              .setcTransportDateScheduledTime(picked);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                        child: Text(Provider.of<TransportData>(context)
                                .cTransport
                                ?.dateScheduleTimeString
                                ?.persianFormat(context) ??
                            "انتخاب کنید"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: Row(
                children: [
                  Text('توقف در مسیر:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kToolbarHeight * 0.2,
                  vertical: kToolbarHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).hintColor.withAlpha(60),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const SizedBox(width: kToolbarHeight * 0.2),
                    const Text(
                      'زمان توقف',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: kToolbarHeight * 0.1),
                    IconButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(
                              side: BorderSide(
                            color: Theme.of(context).hintColor.withAlpha(60),
                          )),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<TransportData>(context, listen: false)
                            .changeMoreTime(1);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minHeight: kMinInteractiveDimension * 0.7,
                        minWidth: kMinInteractiveDimension * 0.7,
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: kToolbarHeight * 1.2,
                      child: Text(
                        "${rialFormat.format(Provider.of<TransportData>(context).cTransport?.moreTime)}  ساعت",
                      ),
                    ),

                    IconButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(
                              side: BorderSide(
                            color: Theme.of(context).hintColor.withAlpha(60),
                          )),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<TransportData>(context, listen: false)
                            .changeMoreTime(-1);
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minHeight: kMinInteractiveDimension * 0.7,
                        minWidth: kMinInteractiveDimension * 0.7,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: Row(
                children: [
                  Text('افزایش کرایه:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kToolbarHeight * 0.2,
                  vertical: kToolbarHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).hintColor.withAlpha(60),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const SizedBox(width: kToolbarHeight * 0.2),
                    const Text(
                      'مبلغ',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: kToolbarHeight * 0.1),
                    IconButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(
                              side: BorderSide(
                            color: Theme.of(context).hintColor.withAlpha(60),
                          )),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<TransportData>(context, listen: false)
                            .changeMorePrice(25000);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minHeight: kMinInteractiveDimension * 0.7,
                        minWidth: kMinInteractiveDimension * 0.7,
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: kToolbarHeight * 1.8,
                      child: Text(
                        "${rialFormat.format(Provider.of<TransportData>(context).cTransport?.morePrice)}  تومان",
                      ),
                    ),

                    IconButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(
                              side: BorderSide(
                            color: Theme.of(context).hintColor.withAlpha(60),
                          )),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<TransportData>(context, listen: false)
                            .changeMorePrice(-25000);
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minHeight: kMinInteractiveDimension * 0.7,
                        minWidth: kMinInteractiveDimension * 0.7,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            const SizedBox(height: kToolbarHeight * 0.3),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
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
                          Provider.of<TransportData>(context, listen: false)
                              .setModalIndex(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: kTextTabBarHeight * 1.1,
                          child: Text(
                            "مرحله قبل",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
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
                          Provider.of<TransportData>(context, listen: false)
                              .setModalIndex(2);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: kTextTabBarHeight * 1.1,
                          child: Text(
                            "مرحله بعد",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
