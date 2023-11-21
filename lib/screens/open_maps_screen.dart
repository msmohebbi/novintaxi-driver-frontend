// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:latlong2/latlong.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:provider/provider.dart';
import '../models/location_model.dart';
import '../providers/func_data.dart';
import '../providers/transport_data.dart';
import '../widgets/general_map_modal.dart';

import '../backend/map.dart';
import '../providers/profile_data.dart';
import '../widgets/app_drawer.dart';

class OpenMapsScreen extends StatefulWidget {
  const OpenMapsScreen({Key? key}) : super(key: key);
  @override
  State<OpenMapsScreen> createState() => OpenMapsScreenState();
}

class OpenMapsScreenState extends State<OpenMapsScreen> {
  @override
  void initState() {
    centerLatLng = kStartPoint.center!;

    mapController.mapEventStream.listen((event) {
      setState(() {
        centerLatLng = event.camera.center;
      });
    });
    Provider.of<ProfileData>(context, listen: false);

    super.initState();
  }

  final kStartPoint = const MapPosition(
    center: LatLng(35.71529, 51.40434),
    zoom: 13,
  );
  var mapController = MapController();

  var searchController = TextEditingController();
  late LatLng centerLatLng;

  bool isLoadingTargetData = false;
  bool isRevGeoing = false;

  List<dynamic> searchItems = [];
  int searchItemsLength = 0;

  List<Polyline> polyLines = [];

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
      var currLocation = await Geolocator.getCurrentPosition();

      return currLocation;
    } catch (_) {
      return null;
    }
  }

  Future<void> serach() async {
    if (isRevGeoing) {
      return;
    }
    setState(() {
      isRevGeoing = true;
    });
    var newIems = await MapBackend().searchOnMap(searchController.text.trim());

    setState(() {
      searchItems = newIems;
      searchItemsLength = searchItems.length;
      isRevGeoing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizee = MediaQuery.of(context).size;
    var widthPix = sizee.width > sizee.height ? sizee.height : sizee.width;
    Future<void> checkZoom(
        List<LatLng> allLatLng, double wSize, double hSized) async {
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
      var xx = mapController.centerZoomFitBounds(
        LatLngBounds(
          LatLng(s, w),
          LatLng(n, e),
        ),
        options: FitBoundsOptions(
            padding: EdgeInsets.symmetric(
          horizontal: wSize * 0.3,
          vertical: hSized * 0.3,
        )),
      );
      setState(() {
        mapController.move(xx.center, xx.zoom);
      });
    }

    var originLocation = Provider.of<TransportData>(context).originLocation;
    var targetLocation = Provider.of<TransportData>(context).targetLocation;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          drawer: const AppDrawer(),
          body: Builder(builder: (context) {
            return Stack(
              alignment: Alignment.center,
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    minZoom: 6,
                    maxZoom: 18,
                    onTap: (newTap, newLatLng) async {},
                    center: LatLng(kStartPoint.center!.latitude,
                        kStartPoint.center!.longitude),
                    zoom: kStartPoint.zoom!,
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
                            height: kToolbarHeight,
                            width: kToolbarHeight,
                            point: originLocation.latLng,
                            // TODO
                            // anchorPos: AnchorPos.align(AnchorAlign.top),
                            child: Icon(
                              Icons.location_on,
                              size: kToolbarHeight,
                              color: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withAlpha(150),
                            ),
                          )
                        ],
                        if (targetLocation != null) ...[
                          Marker(
                            height: kToolbarHeight,
                            width: kToolbarHeight,
                            point: targetLocation.latLng,
                            // TODO
                            // anchorPos: AnchorPos.align(AnchorAlign.top),
                            child: Icon(
                              Icons.location_on,
                              size: kToolbarHeight,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
                if (targetLocation == null) ...[
                  Container(
                    height: kToolbarHeight * 2,
                    width: kToolbarHeight,
                    padding: const EdgeInsets.only(bottom: kToolbarHeight),
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.location_on,
                      size: kToolbarHeight,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                Positioned(
                  top: 20,
                  right: 0,
                  width: widthPix,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: kToolbarHeight * 0.2),
                          Flexible(
                            flex: 1,
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.background,
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: kToolbarHeight,
                                  height: kToolbarHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: kToolbarHeight * 0.25,
                                    ),
                                    child: Icon(Icons.menu),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.2),
                          Expanded(
                            flex: 4,
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minHeight: kToolbarHeight),
                                  // height: kToolbarHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      TextField(
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onSubmitted: (newText) async {
                                          await serach();
                                        },
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                          hintText:
                                              "مکان مورد نظر را جستجو کنید ...",
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                left: kToolbarHeight * 0.2),
                                            child: InkWell(
                                              onTap: () async {
                                                await serach();
                                              },
                                              child: isRevGeoing
                                                  ? const CupertinoActivityIndicator()
                                                  : const Icon(
                                                      CupertinoIcons.search),
                                            ),
                                          ),
                                        ),
                                        controller: searchController,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          // maxWidth: MediaQuery.of(context).size.height / 3,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ...searchItems.map(
                                                (e) => ListTile(
                                                  title: Text(
                                                    e["title"] ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    e["address"] ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  trailing: const Icon(
                                                      Icons.arrow_forward_ios),
                                                  onTap: () {
                                                    var newLatLng = LatLng(
                                                      e["location"]["y"],
                                                      e["location"]["x"],
                                                    );
                                                    setState(() {
                                                      _goToThePlace(
                                                        MapPosition(
                                                          center: newLatLng,
                                                          zoom: 16,
                                                        ),
                                                      );
                                                      searchController.text =
                                                          e["address"];
                                                      searchItems = [];
                                                      searchItemsLength = 0;
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: kToolbarHeight * 0.2),
                        ],
                      ),
                      if (originLocation != null) ...[
                        const SizedBox(height: kToolbarHeight * 0.1),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: kToolbarHeight * 0.2),
                            Flexible(
                              flex: 1,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.background,
                                child: Container(
                                  height: kToolbarHeight,
                                  width: kToolbarHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: const FittedBox(
                                    child: Text(
                                      "مبدا",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: kToolbarHeight * 0.2),
                            Expanded(
                              flex: 4,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        kToolbarHeight * 0.2),
                                    height: kToolbarHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    // alignment: Alignment.center,
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            Provider.of<TransportData>(context)
                                                    .originLocation
                                                    ?.desc ??
                                                '...',
                                            softWrap: true,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: kToolbarHeight * 0.1),
                                          child: InkWell(
                                            onTap: () {
                                              Provider.of<TransportData>(
                                                      context,
                                                      listen: false)
                                                  .settargetLocation(null);

                                              polyLines = [];
                                              Provider.of<TransportData>(
                                                      context,
                                                      listen: false)
                                                  .setoriginLocation(null);
                                            },
                                            child: const Icon(Icons.close),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: kToolbarHeight * 0.2),
                          ],
                        ),
                      ],
                      if (targetLocation != null) ...[
                        const SizedBox(height: kToolbarHeight * 0.1),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: kToolbarHeight * 0.2),
                            Flexible(
                              flex: 1,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.background,
                                child: Container(
                                  height: kToolbarHeight,
                                  width: kToolbarHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: const FittedBox(
                                    child: Text(
                                      "مقصد",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: kToolbarHeight * 0.2),
                            Expanded(
                              flex: 4,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        kToolbarHeight * 0.2),
                                    height: kToolbarHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    // alignment: Alignment.center,
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            Provider.of<TransportData>(context)
                                                    .targetLocation
                                                    ?.desc ??
                                                '...',
                                            softWrap: true,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: kToolbarHeight * 0.1),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Provider.of<TransportData>(
                                                          context,
                                                          listen: false)
                                                      .settargetLocation(null);

                                                  polyLines = [];
                                                });
                                              },
                                              child: const Icon(Icons.close)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: kToolbarHeight * 0.2),
                          ],
                        ),
                      ],
                    ],
                  ),
                )
              ],
            );
          }),
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
                          mapController.move(
                              mapController.center, mapController.zoom + 1);
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
                          mapController.move(
                              mapController.center, mapController.zoom - 1);
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
                Material(
                  elevation: 5,
                  color: isLoadingTargetData
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async {
                      if (isLoadingTargetData) {
                        return;
                      }
                      if (originLocation != null && targetLocation != null) {
                        setState(() {
                          isLoadingTargetData = true;
                        });
                        await Provider.of<TransportData>(context, listen: false)
                            .createTransport();
                        Provider.of<TransportData>(context, listen: false)
                            .changeclientName(
                                Provider.of<ProfileData>(context, listen: false)
                                        .cUserProfile
                                        ?.name ??
                                    "");
                        Provider.of<TransportData>(context, listen: false)
                            .changeclientPhone(
                                Provider.of<ProfileData>(context, listen: false)
                                        .cUserProfile
                                        ?.username ??
                                    "");
                        setState(() {
                          isLoadingTargetData = false;
                        });
                        FuncData().showNotificationModal(
                          const GeneralMapModal(),
                          context,
                        );
                        return;
                      }

                      var isOrigin = originLocation == null;
                      setState(() {
                        polyLines.clear();
                        isLoadingTargetData = true;
                      });

                      // Reverse Geocoding ---------------------------------------------------------------------------------------
                      var revGeo = await MapBackend().reverseGeocoding(
                          mapController.center.latitude,
                          mapController.center.longitude);
                      var newLocation = AppLocation.fromMap(revGeo);
                      if (isOrigin) {
                        Provider.of<TransportData>(context, listen: false)
                            .setoriginLocation(newLocation);
                        setState(() {
                          isLoadingTargetData = false;
                        });
                        return;
                      } else {
                        if (originLocation.city == newLocation.city) {
                          FuncData().showSnack(
                            ctx: context,
                            mainText: "مبدا و مقصد باید از دو شهر متفاوت باشند",
                            buttonText: 'تایید',
                            isError: true,
                            buttonFunc: () =>
                                ScaffoldMessenger.of(context).clearSnackBars(),
                          );
                          setState(() {
                            isLoadingTargetData = false;
                          });
                          return;
                        }
                        Provider.of<TransportData>(context, listen: false)
                            .settargetLocation(newLocation);
                      }

                      // straight PolyLine ----------------------------------------------------------------------------
                      if (!isOrigin) {
                        setState(() {
                          polyLines.add(
                            Polyline(
                              isDotted: true,
                              strokeWidth: 5,
                              color: Colors.greenAccent,
                              points: MapsCurvedLines.getPointsOnCurve(
                                gmap.LatLng(
                                    originLocation.lat, originLocation.lng),
                                gmap.LatLng(mapController.center.latitude,
                                    mapController.center.longitude),
                              )
                                  .map(
                                    (e) => LatLng(e.latitude, e.longitude),
                                  )
                                  .toList(),
                            ),
                          );
                        });
                        // check zoom level --------------------------------------------------------------------------------------
                        var wid = MediaQuery.of(context).size.width;
                        var hei = MediaQuery.of(context).size.height;

                        checkZoom(
                          [
                            Provider.of<TransportData>(context, listen: false)
                                .originLocation!
                                .latLng,
                            Provider.of<TransportData>(context, listen: false)
                                .targetLocation!
                                .latLng
                          ],
                          wid,
                          hei,
                        );
                      }
                      setState(() {
                        isLoadingTargetData = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: kTextTabBarHeight * 1.1,
                      width: widthPix * 0.5,
                      child: isLoadingTargetData
                          ? CupertinoActivityIndicator(
                              color: Theme.of(context).colorScheme.background,
                            )
                          : Text(
                              targetLocation != null
                                  ? "تایید مبدا و مقصد"
                                  : originLocation == null
                                      ? "انتخاب مبدا"
                                      : "انتخاب مقصد",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  heroTag: "gps",
                  onPressed: () async {
                    setState(() {
                      isLoadingTargetData = true;
                    });
                    var currLocation = await getCurrentLocation();
                    if (currLocation != null) {
                      var newLatLng =
                          LatLng(currLocation.latitude, currLocation.longitude);

                      await _goToThePlace(
                          MapPosition(center: newLatLng, zoom: 16));
                    }
                    setState(() {
                      isLoadingTargetData = false;
                    });
                  },
                  child: const Icon(Icons.gps_fixed),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToThePlace(MapPosition newCameraPos) async {
    // final MapController controller = await controller.future;
    mapController.move(newCameraPos.center!, newCameraPos.zoom!);
  }
}
