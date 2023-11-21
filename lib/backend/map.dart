import 'dart:convert';
import 'dart:developer';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:latlong2/latlong.dart' as lt;
import 'package:http/http.dart' as htp;

import '../const/const.dart';

class MapBackend {
  final String _baseUrl = apiUrl;

  Future<Map<String, dynamic>> reverseGeocoding(
      double targetlat, double targetLng) async {
    Uri url = Uri.parse(
        "$_baseUrl/map/reverse_geo_location/?target_lat=${targetlat.toStringAsFixed(5)}&target_lng=${targetLng.toStringAsFixed(5)}");
    log(url.toString());
    var revRes = await htp.get(url, headers: {
      // "Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"
    });
    log(revRes.statusCode.toString());
    log(revRes.body);
    if (revRes.statusCode == 200) {
      return json.decode(utf8.decode(revRes.bodyBytes));
    } else {
      return {};
    }
  }

  dynamic matrix(lt.LatLng origin, List<lt.LatLng> markerList) async {
    String locationsString = "";
    for (var element in markerList) {
      if (markerList.indexOf(element) > 0) {
        locationsString = "$locationsString|";
      }
      locationsString =
          "$locationsString${element.latitude.toStringAsFixed(5)},${element.longitude.toStringAsFixed(5)}";
    }
    Uri matrixUrl = Uri.parse(
        "$_baseUrl/map/neshanmatrix?originLat=${origin.latitude}&originLng=${origin.longitude}&locationsString=$locationsString");
    log(matrixUrl.toString());
    var matrixRes = await htp.get(matrixUrl, headers: {
      // "Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"
    });
    log(matrixRes.statusCode.toString());
    if (matrixRes.statusCode == 200) {
      log(markerList.length.toString());
      var total = json.decode(utf8.decode(matrixRes.bodyBytes));
      return total;
    } else {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> searchOnMap(searchText) async {
    Uri searchUrl =
        Uri.parse("$_baseUrl/map/search/?text=$searchText&city eq کرمان");
    log(searchUrl.toString());
    var sortingRes = await htp.get(
      searchUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // "Authorization": "JWT ${accessToken}",
      },
    );
    log(sortingRes.statusCode.toString());
    // log(markerList.length.toString());
    log(json.decode(sortingRes.body).toString());
    if (sortingRes.statusCode == 200) {
      // log(json.decode(sortingRes.body)["value"].toString());
      return [...json.decode(utf8.decode(sortingRes.bodyBytes))];
    } else {
      return [];
    }
  }

  // Future<List<Map<String, dynamic>>> searchOnMapNeshan(
  //     searchText, LatLng tarrgetLatLng) async {
  //   Uri url = Uri.parse(
  //       "api.neshan.org/v1/search?term=$searchText&lat=${tarrgetLatLng.latitude}&lng=${tarrgetLatLng.longitude}");
  //   log(url.toString());
  //   var searchRes = await htp.get(url, headers: {
  //     "Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"
  //   });
  //   log(searchRes.statusCode.toString());
  //   log(searchRes.body.toString());

  //   if (searchRes.statusCode == 200) {
  //     return json.decode(searchRes.body)["items"];
  //   } else {
  //     return [];
  //   }
  // }

  Future<Map<String, dynamic>> fDGMapIr(
      List<gmap.LatLng> markerList, bool isBack) async {
    String sortingLocationsString = "";
    for (var element in markerList) {
      if (markerList.indexOf(element) > 0) {
        sortingLocationsString = "$sortingLocationsString:";
      }
      sortingLocationsString =
          "$sortingLocationsString${element.longitude.toStringAsFixed(5)},${element.latitude.toStringAsFixed(5)}";
    }
    String isBackString = isBack ? "1" : "0";

    Uri sotingUrl = Uri.parse(
        "$_baseUrl/map/tsp?locationsString=$sortingLocationsString&isBack=$isBackString");
    log(sotingUrl.toString());
    var sortingRes = await htp.get(
      sotingUrl,
      headers: {
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
      },
    );
    log(sortingRes.statusCode.toString());
    log(sortingRes.body.toString());
    if (sortingRes.statusCode == 200) {
      var totalData = json.decode(sortingRes.body);
      // log(totalData.toString());
      return totalData;
    } else {
      return {};
    }
  }
}

  // // Forooshandeh DoreGard Neshan-------------------------------------------------------------------------------------------------
  // String sortingLocationsString = "";
  // for (var element in markerList) {
  //   if (markerList.indexOf(element) > 0) {
  //     sortingLocationsString = "$sortingLocationsString|";
  //   }
  //   sortingLocationsString =
  //       "$sortingLocationsString${element.position.latitude.toStringAsFixed(5)},${element.position.longitude.toStringAsFixed(5)}";
  // }
  // Uri sotingUrl = Uri.parse(
  //     "api.neshan.org/v3/trip?waypoints=$sortingLocationsString&roundTrip=false&lastIsAnyPoint=true&sourceIsAnyPoint=true");
  // log(sotingUrl.toString());
  // var sortingRes = await htp.get(sotingUrl, headers: {
  //   "Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"
  // });
  // log(sortingRes.statusCode.toString());
  // if (sortingRes.statusCode == 200) {
  //   // log(markerList.length.toString());
  //   log(sortingRes.body.toString());
  //   markerList.clear();
  //   setState(() {
  //     json.decode(sortingRes.body)["points"].forEach((xy) {
  //       var newmarker = Marker(
  //         markerId: MarkerId(xy["index"].toString()),
  //         position: LatLng(xy["location"][0], xy["location"][1]),
  //       );
  //       markerList.add(newmarker);
  //     });
  //     markerList.sort((a, b) {
  //       return (int.parse(a.markerId.value))
  //           .compareTo((int.parse(b.markerId.value)));
  //     });
  //   });
  // }

   // // PolyLine ----------------------------------------------------------------------------------------------
// String polylocationsString = "";
// for (var element in markerList) {
//   if (markerList.indexOf(element) > 1) {
//     polylocationsString = "$polylocationsString|";
//   }
//   if (markerList.indexOf(element) > 0 &&
//       markerList.indexOf(element) < markerList.length - 1) {
//     polylocationsString =
//         "$polylocationsString${element.position.latitude.toStringAsFixed(5)},${element.position.longitude.toStringAsFixed(5)}";
//   }
// }
// String totalpolylocationsString =
//     "type=car&origin=${markerList.first.position.latitude.toStringAsFixed(5)},${markerList.first.position.longitude.toStringAsFixed(5)}&destination=${markerList.last.position.latitude.toStringAsFixed(5)},${markerList.last.position.longitude.toStringAsFixed(5)}";
// if (polylocationsString != "") {
//   totalpolylocationsString =
//       "${totalpolylocationsString}&waypoints=$polylocationsString";
// }
// Uri polyurl = Uri.parse(
//     "api.neshan.org/v3/direction?$totalpolylocationsString");
// log(polyurl.toString());
// var polyRes = await htp.get(polyurl, headers: {
//   "Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"
// });
// if (polyRes.statusCode == 200) {
//   log(polyRes.statusCode.toString());
//   log(markerList.length.toString());
//   // log(polyRes.body.toString());
//   _polyLines.clear();
//   String xxcode = json.decode(polyRes.body)["routes"][0]
//       ["overview_polyline"]["points"];
//   // log(xxcode.toString());
//   setState(() {
//     _polyLines.add(
//       Polyline(
//         width: 3,
//         polylineId: PolylineId(Random.secure().nextInt(100000).toString()),
//         points: PolylinePoints()
//             .decodePolyline(xxcode)
//             .map((e) => LatLng(e.latitude, e.longitude))
//             .toList(),
//       ),
//     );
//   });
// }