import 'location_model.dart';

class AppUserLocation {
  AppUserLocation({
    required this.userLocationId,
    required this.location,
    required this.dateCreated,
    required this.isSaved,
  });
  int userLocationId;
  AppLocation location;
  int dateCreated;
  bool isSaved;
  Map<String, dynamic> toMap() {
    return {
      "location": location.toMap(),
      "isSaved": isSaved,
    };
  }

  AppUserLocation.fromMap(Map<String, dynamic> newLocation)
      : userLocationId = newLocation["id"],
        location = AppLocation.fromMap(newLocation["location"]),
        dateCreated = newLocation["dateCreated"],
        isSaved = newLocation["isSaved"];
}
