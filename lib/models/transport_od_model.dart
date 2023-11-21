import '../models/location_model.dart';
import '../models/transport_model.dart';

class AppTransportOD {
  AppTransportOD({
    required this.id,
    required this.transport,
    required this.location,
    required this.isStart,
    required this.isEnd,
    required this.order,
    required this.map,
    required this.status,
  });
  int id;
  AppTransport transport;
  AppLocation location;
  bool isStart;
  bool isEnd;
  int order;
  String status;
  String map;

  Map<String, dynamic> toMap() {
    var mapedObj = {
      "is_start": isStart,
      "is_end": isEnd,
      "order": order,
      "location": location.toMap(),
    };
    return mapedObj;
  }

  AppTransportOD.fromMap(Map<String, dynamic> newOrder)
      : id = newOrder["id"],
        transport = newOrder["transport"],
        location = newOrder["location"],
        isStart = newOrder["is_start"],
        isEnd = newOrder["is_end"],
        order = newOrder["order"],
        status = newOrder["status"],
        map = newOrder["map"];
}
