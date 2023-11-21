class AppNotificationSubsribe {
  AppNotificationSubsribe({
    required this.id,
    required this.type,
    required this.destination,
  });
  int id;
  String type;
  int? destination;

  AppNotificationSubsribe.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        type = newItem["type"],
        destination = newItem["destination"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "destination": destination,
    };
  }
}
