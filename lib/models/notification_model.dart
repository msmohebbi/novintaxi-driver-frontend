import './raw_notification_model.dart';

class AppNotification {
  AppNotification({
    required this.id,
    required this.type,
    required this.destination,
    required this.notificationData,
    required this.date,
  });
  int id;
  String type;
  String? destination;
  AppRawNotification notificationData;
  int date;

  AppNotification.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        type = newItem["type"],
        destination = newItem["destination"],
        notificationData =
            AppRawNotification.fromMap(newItem["notificationData"]),
        date = newItem["date"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "destination": destination,
      "notificationData": notificationData.toMap(),
      "date": date,
    };
  }
}
