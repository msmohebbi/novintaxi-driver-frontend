import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart' as intl;
import 'package:latlong2/latlong.dart';
import 'package:novintaxidriver/models/location_model.dart';
import 'package:novintaxidriver/widgets/confirm_transport_dialog.dart';
import 'package:persian/persian.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:novintaxidriver/models/transport_model.dart';
import 'package:novintaxidriver/providers/driver_transport_data.dart';

class TransportCompact extends StatefulWidget {
  final AppTransport cTransport;

  const TransportCompact({super.key, required this.cTransport});

  @override
  State<TransportCompact> createState() => _TransportCompactState();
}

class _TransportCompactState extends State<TransportCompact> {
  var mapController = MapController();
  List<Polyline> polyLines = [];
  late AppLocation? originLocation;
  late AppLocation? targetLocation;

  @override
  void initState() {
    originLocation = widget.cTransport.ods?.firstOrNull?.location;
    targetLocation = widget.cTransport.ods?.lastOrNull?.location;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        mapController.move(originLocation!.latLng, 11);
        mapController.move(
          targetLocation!.latLng,
          11,
        );
        await checkZoom(
          [originLocation!.latLng, targetLocation!.latLng],
        );
        if (widget.cTransport.geometery != null) {
          await Future.delayed(const Duration(milliseconds: 200));

          polyLines.clear();
          var geometry = json.decode(widget.cTransport.geometery!);
          var legLatLngs = [];
          legLatLngs
              .addAll(geometry["coordinates"].map((e) => LatLng(e[1], e[0])));
          setState(() {
            polyLines.add(
              Polyline(
                color: Theme.of(context).colorScheme.error,
                strokeWidth: 5,
                points: [...legLatLngs],
              ),
            );
          });
        }
      },
    );
    super.initState();
  }

  Future<void> checkZoom(List<LatLng> allLatLng) async {
    double n = allLatLng[0].latitude;
    double s = allLatLng[0].latitude;
    double w = allLatLng[0].longitude;
    double e = allLatLng[0].longitude;
    for (var element in allLatLng) {
      if (element.latitude > n) {
        n = element.latitude;
      }
      if (element.latitude < s) {
        s = element.latitude;
      }
      if (element.longitude > e) {
        e = element.longitude;
      }
      if (element.longitude < w) {
        w = element.longitude;
      }
    }
    var xx = CameraFit.bounds(
      bounds: LatLngBounds(
        LatLng(s, w),
        LatLng(n, e),
      ),
      padding: const EdgeInsets.only(
        left: kToolbarHeight * 0.4,
        right: kToolbarHeight * 0.4,
        bottom: kToolbarHeight * 0.4,
        top: kToolbarHeight * 1,
      ),
    ).fit(mapController.camera);

    mapController.move(
      xx.center,
      xx.zoom,
    );
  }

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
                      'مسافت سفر:',
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kToolbarHeight * 0.2,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: kToolbarHeight * 5,
                child: IgnorePointer(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      minZoom: 4,
                      maxZoom: 13,
                      onTap: (newTap, newLatLng) async {},
                      initialCenter:
                          widget.cTransport.ods!.first.location.latLng,
                      initialZoom: 11,
                    ),
                    children: [
                      TileLayer(
                        // attributionAlignment: Alignment.bottomCenter,
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        tileBuilder: (context, tileWidget, tile) {
                          return tileWidget;
                        },
                      ),
                      PolylineLayer(
                        polylines: polyLines,
                      ),
                      MarkerLayer(
                        markers: [
                          if (originLocation != null) ...[
                            Marker(
                              alignment: Alignment.topCenter,
                              height: kToolbarHeight,
                              width: kToolbarHeight,
                              point: originLocation!.latLng,
                              child: Stack(
                                children: [
                                  Icon(
                                    CupertinoIcons.bubble_middle_bottom_fill,
                                    size: kToolbarHeight,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withAlpha(180),
                                  ),
                                  const Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: FittedBox(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: kToolbarHeight * 0.2,
                                          ),
                                          child: Text('مبدا'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                          if (targetLocation != null) ...[
                            Marker(
                              height: kToolbarHeight,
                              width: kToolbarHeight,
                              point: targetLocation!.latLng,
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: [
                                  Icon(
                                    CupertinoIcons.bubble_middle_bottom_fill,
                                    size: kToolbarHeight,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withAlpha(180),
                                  ),
                                  const Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: FittedBox(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: kToolbarHeight * 0.2,
                                          ),
                                          child: Text('مقصد'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
                          return ConfirmTransportDialog(
                              cTransport: widget.cTransport);
                        },
                      );
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
