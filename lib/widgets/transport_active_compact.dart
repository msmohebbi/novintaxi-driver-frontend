import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:provider/provider.dart';

import 'package:transportationdriver/models/driver_transport_model.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:transportationdriver/providers/driver_transport_data.dart';
import 'package:transportationdriver/screens/open_maps_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportActiveCompact extends StatefulWidget {
  final AppDriverTransport cDriverTransport;

  const TransportActiveCompact({super.key, required this.cDriverTransport});

  @override
  State<TransportActiveCompact> createState() => _TransportActiveCompactState();
}

class _TransportActiveCompactState extends State<TransportActiveCompact> {
  @override
  Widget build(BuildContext context) {
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
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cDriverTransport.transport.ods?.first.location
                                .city ??
                            '',
                      ),
                    ],
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      const Icon(Icons.arrow_circle_left_outlined),
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(widget.cDriverTransport.transport.ods?.last.location
                              .city ??
                          ''),
                    ],
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Row(
                  children: [
                    const Text(
                      'مدت زمان:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(widget.cDriverTransport.transport.timeString),
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
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                          '${widget.cDriverTransport.transport.meterKMString} کیلومتر'),
                    ],
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.3),
                Row(
                  children: [
                    const Text(
                      'درآمد:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                          '${widget.cDriverTransport.transport.revenueString} تومان'),
                    ],
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.cDriverTransport.navigatorButtonString !=
                        null) ...[
                      Material(
                        color: Theme.of(context).hintColor.withAlpha(100),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return OpenMapsScreen(
                                    cTransport:
                                        widget.cDriverTransport.transport);
                              },
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.15,
                              horizontal: kToolbarHeight * 0.2,
                            ),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.map),
                                const SizedBox(width: kToolbarHeight * 0.1),
                                Text(
                                  'خلاصه سفر',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: kToolbarHeight * 0.2),
                      Material(
                        color: Theme.of(context).hintColor.withAlpha(100),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (widget.cDriverTransport.statusId == 0) {
                              MapsLauncher.launchCoordinates(
                                widget.cDriverTransport.transport.ods!.first
                                    .location.lat,
                                widget.cDriverTransport.transport.ods!.first
                                    .location.lng,
                              );
                            } else {
                              MapsLauncher.launchCoordinates(
                                widget.cDriverTransport.transport.ods!.last
                                    .location.lat,
                                widget.cDriverTransport.transport.ods!.last
                                    .location.lng,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.15,
                              horizontal: kToolbarHeight * 0.2,
                            ),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.location_circle),
                                const SizedBox(width: kToolbarHeight * 0.1),
                                Text(
                                  widget
                                      .cDriverTransport.navigatorButtonString!,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
          const SizedBox(height: kToolbarHeight * 0.2),
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
                      'نوع سفر:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: kToolbarHeight * 0.1,
                    ),
                    Text(
                      widget.cDriverTransport.transport.typeFa,
                    ),
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.3),
                Row(
                  children: [
                    const Text(
                      'تعداد مسافر:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cDriverTransport.transport.passengersCountString,
                      ),
                    ],
                  ],
                ),
                if (widget.cDriverTransport.transport.dateSchedule != null) ...[
                  const SizedBox(height: kToolbarHeight * 0.2),
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
                        widget.cDriverTransport.transport
                                .dateScheduleDateString ??
                            '',
                      ),
                      const SizedBox(
                        width: kToolbarHeight * 0.1,
                      ),
                      Text(
                        widget.cDriverTransport.transport.dateScheduleTimeString
                                ?.format(context)
                                .withPersianNumbers() ??
                            '',
                      ),
                    ],
                  )
                ],
                const SizedBox(height: kToolbarHeight * 0.2),
                Row(
                  children: [
                    const Text(
                      'نام مسافر:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: kToolbarHeight * 0.1,
                    ),
                    Text(
                      widget.cDriverTransport.transport.passengerName ?? '',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          if (widget.cDriverTransport.statusId < 3) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Theme.of(context).hintColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              "tel://${widget.cDriverTransport.transport.passengerPhone}"),
                        );
                      },
                      child: Container(
                        width: kToolbarHeight * 2,
                        padding: const EdgeInsets.symmetric(
                          vertical: kToolbarHeight * 0.15,
                          horizontal: kToolbarHeight * 0.1,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.phone_arrow_up_right,
                              color: Colors.green[600],
                              size: 20,
                            ),
                            const SizedBox(width: kToolbarHeight * 0.2),
                            const Text(
                              'تماس',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  width: kToolbarHeight * 0.2,
                ),
                Material(
                  color: Theme.of(context).hintColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              "sms://${widget.cDriverTransport.transport.passengerPhone}"),
                        );
                      },
                      child: Container(
                        width: kToolbarHeight * 2,
                        padding: const EdgeInsets.symmetric(
                          vertical: kToolbarHeight * 0.15,
                          horizontal: kToolbarHeight * 0.1,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.bubble_left_bubble_right,
                              color: Colors.orange[800],
                            ),
                            const SizedBox(width: kToolbarHeight * 0.2),
                            const Text(
                              'پیامک',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
          const SizedBox(height: kToolbarHeight * 0.2),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primary.withAlpha(180),
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'وضعیت فعلی:',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    width: kToolbarHeight * 0.1,
                  ),
                  Text(
                    widget.cDriverTransport.status,
                  ),
                ],
              ),
              if (widget.cDriverTransport.actionButtonString != null) ...[
                const SizedBox(height: kToolbarHeight * 0.2),
                Material(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Provider.of<DriverTransportData>(context, listen: false)
                          .updateDriverTransport(widget.cDriverTransport);
                    },
                    child: Provider.of<DriverTransportData>(context).isUpdating
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.2,
                              horizontal: kToolbarHeight * 0.8,
                            ),
                            child: CupertinoActivityIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.2,
                              horizontal: kToolbarHeight * 0.4,
                            ),
                            child: Text(
                              widget.cDriverTransport.actionButtonString!,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primary.withAlpha(180),
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widget.cDriverTransport.isCanceled &&
                  widget.cDriverTransport.dateEnded == null) ...[
                Material(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showCupertinoDialog(
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
                                    'شما درحال لغو سفر خود هستید، \n آیا مطمئن هستید؟',
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 13,
                                      fontFamily: 'IRANYekan',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: kToolbarHeight * 0.1),
                                  Text(
                                    '(در هر روز فقط امکان لغو ۳ سفر را دارید)',
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
                                        .cancelDriverTransport(
                                            widget.cDriverTransport);

                                    if (mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  icon: Text(
                                    'لغو سفر',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
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
                    },
                    child: Provider.of<DriverTransportData>(context).isCanceling
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kToolbarHeight * 0.2,
                              horizontal: kToolbarHeight * 0.65,
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
                              'لغو سفر',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
              const SizedBox(height: kToolbarHeight * 0.2),
            ],
          ),
        ],
      ),
    );
  }
}
