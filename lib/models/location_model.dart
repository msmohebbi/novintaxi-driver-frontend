import 'package:latlong2/latlong.dart';

class AppLocation {
  AppLocation({
    required this.id,
    required this.lat,
    required this.lng,
    required this.desc,
    this.city,
  });
  int id;
  double lat;
  double lng;
  String desc;
  String? city;
  LatLng get latLng {
    return LatLng(lat, lng);
  }

  Map<String, dynamic> toMap() {
    return {
      "lat": lat,
      "lng": lng,
      "desc": desc,
      "city": city,
    };
  }

  AppLocation.fromMap(Map<String, dynamic> newLocation)
      : id = newLocation["id"] ?? 0,
        lat = newLocation["lat"],
        lng = newLocation["lng"],
        desc = newLocation["desc"],
        city = newLocation["city"];
}
