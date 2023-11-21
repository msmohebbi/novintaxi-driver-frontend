import './notification_model.dart';

class AppUserNotification {
  AppUserNotification({
    required this.id,
    required this.notification,
    required this.date,
    required this.isRead,
  });
  int id;
  AppNotification notification;
  int date;
  bool isRead;

  AppUserNotification.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        notification = AppNotification.fromMap(newItem["notification"]),
        isRead = newItem["isRead"],
        date = newItem["date"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "notification": notification.toMap(),
      "date": date,
      "isRead": isRead,
    };
  }
}
