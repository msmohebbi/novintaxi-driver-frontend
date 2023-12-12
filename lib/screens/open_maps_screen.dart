// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:transportationdriver/models/location_model.dart';
import 'package:transportationdriver/models/transport_model.dart';

class OpenMapsScreen extends StatefulWidget {
  final AppTransport cTransport;

  const OpenMapsScreen({super.key, required this.cTransport});
  @override
  State<OpenMapsScreen> createState() => OpenMapsScreenState();
}

class OpenMapsScreenState extends State<OpenMapsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
    );
    originLocation = widget.cTransport.ods?.firstOrNull?.location;
    targetLocation = widget.cTransport.ods?.lastOrNull?.location;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(const Duration(milliseconds: 200));
        await mapController.animateTo(dest: originLocation!.latLng, zoom: 11);
        await mapController.animateTo(
          dest: targetLocation!.latLng,
          zoom: 11,
        );
        // await Future.delayed(const Duration(milliseconds: 200));
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

  final kStartPoint = const MapPosition(
    center: LatLng(35.71529, 51.40434),
    zoom: 8,
  );

  AppLocation? originLocation;
  AppLocation? targetLocation;
  LatLng? currentLatLng;
  List<Polyline> polyLines = [];
  late final AnimatedMapController mapController;
  var isGPSing = false;

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    try {
      setState(() {
        isGPSing = true;
      });

      var currLocation = await Geolocator.getCurrentPosition();
      setState(() {
        isGPSing = false;
      });

      return currLocation;
    } catch (_) {
      setState(() {
        isGPSing = false;
      });
      return null;
    }
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
      padding: const EdgeInsets.symmetric(
        horizontal: kToolbarHeight * 2,
        vertical: kToolbarHeight * 2,
      ),
    ).fit(mapController.mapController.camera);

    await mapController.animateTo(
      dest: xx.center,
      zoom: xx.zoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 2,
            shadowColor: Theme.of(context).hintColor.withAlpha(100),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "خلاصه سفر",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              FlutterMap(
                mapController: mapController.mapController,
                options: MapOptions(
                  minZoom: 6,
                  maxZoom: 18,
                  initialCenter: kStartPoint.center!,
                  initialZoom: kStartPoint.zoom!,
                  onTap: (newTap, newLatLng) async {},
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
                      if (currentLatLng != null) ...[
                        Marker(
                          height: kToolbarHeight,
                          width: kToolbarHeight,
                          point: currentLatLng!,
                          alignment: Alignment.topCenter,
                          child: const Stack(
                            children: [
                              Icon(
                                CupertinoIcons.bubble_middle_bottom_fill,
                                size: kToolbarHeight,
                                color: Colors.teal,
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: kToolbarHeight * 0.2,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.car_detailed,
                                        color: Colors.white,
                                      ),
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
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kToolbarHeight * 0.2,
              vertical: kToolbarHeight * 0.5,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    FloatingActionButton(
                      heroTag: "zoom+",
                      onPressed: () {
                        setState(() {
                          mapController.mapController.move(
                              mapController.mapController.camera.center,
                              mapController.mapController.camera.zoom + 1);
                        });
                      },
                      backgroundColor: Theme.of(context).colorScheme.background,
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight * 0.2),
                    FloatingActionButton(
                      heroTag: "zoom-",
                      onPressed: () {
                        setState(() {
                          mapController.mapController.move(
                              mapController.mapController.camera.center,
                              mapController.mapController.camera.zoom - 1);
                        });
                      },
                      backgroundColor: Theme.of(context).colorScheme.background,
                      child: Icon(
                        Icons.remove,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  heroTag: "gps",
                  onPressed: () async {
                    var currLocation = await getCurrentLocation();
                    if (currLocation != null) {
                      setState(() {
                        currentLatLng = LatLng(
                            currLocation.latitude, currLocation.longitude);
                      });
                      checkZoom(
                        [
                          originLocation!.latLng,
                          targetLocation!.latLng,
                          if (currentLatLng != null) ...[currentLatLng!]
                        ],
                      );
                    }
                  },
                  child: isGPSing
                      ? const CupertinoActivityIndicator()
                      : const Icon(Icons.gps_fixed),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
