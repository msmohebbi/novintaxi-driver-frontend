import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:transportationdriver/models/driver_transport_model.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:transportationdriver/providers/driver_transport_data.dart';

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
                      'مبدا:',
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
                  ],
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Row(
                  children: [
                    const Text(
                      'مقصد:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.cDriverTransport.transport.ods?.isNotEmpty ??
                        false) ...[
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
                const SizedBox(height: kToolbarHeight * 0.2),
                widget.cDriverTransport.transport.dateSchedule != null
                    ? Row(
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
                                .dateScheduleDateString!
                                .toString(),
                          ),
                          const SizedBox(
                            width: kToolbarHeight * 0.1,
                          ),
                          Text(
                            widget.cDriverTransport.transport
                                    .dateScheduleTimeString
                                    ?.format(context) ??
                                '',
                          ),
                        ],
                      )
                    : Container(),
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
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Provider.of<DriverTransportData>(context)
                        //     .updateDriverTransport(widget.cDriverTransport);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: kToolbarHeight * 0.1,
                            horizontal: kToolbarHeight * 0.4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            SizedBox(width: kToolbarHeight * 0.1),
                            Text(
                              'تماس با مشتری',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
          ],
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
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primary.withAlpha(180),
          ),
          if (widget.cDriverTransport.actionButtonString != null) ...[
            const SizedBox(height: kToolbarHeight * 0.3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Provider.of<DriverTransportData>(context, listen: false)
                            .updateDriverTransport(widget.cDriverTransport);
                      },
                      child:
                          Provider.of<DriverTransportData>(context).isUpdating
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: kToolbarHeight * 0.2,
                                    horizontal: kToolbarHeight * 0.8,
                                  ),
                                  child: CupertinoActivityIndicator(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: kToolbarHeight * 0.2,
                                    horizontal: kToolbarHeight * 0.4,
                                  ),
                                  child: Text(
                                    widget.cDriverTransport.actionButtonString!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                ),
              ],
            ),
          ],
          const SizedBox(height: kToolbarHeight * 0.3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widget.cDriverTransport.isCanceled &&
                  widget.cDriverTransport.dateEnded == null) ...[
                Material(
                  color: Theme.of(context).hintColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Provider.of<DriverTransportData>(context, listen: false)
                            .cancelDriverTransport(widget.cDriverTransport);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: kToolbarHeight * 0.2,
                            horizontal: kToolbarHeight * 0.4),
                        child: Text('لغو سفر'),
                      )),
                ),
              ],
              if (widget.cDriverTransport.navigatorButtonString != null) ...[
                const SizedBox(width: kToolbarHeight * 0.3),
                Material(
                  color: Colors.teal,
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
                            widget.cDriverTransport.transport.ods!.last.location
                                .lat,
                            widget.cDriverTransport.transport.ods!.last.location
                                .lng,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kToolbarHeight * 0.2,
                          horizontal: kToolbarHeight * 0.4,
                        ),
                        child: Text(
                          widget.cDriverTransport.navigatorButtonString!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
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
