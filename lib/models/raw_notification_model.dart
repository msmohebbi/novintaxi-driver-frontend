class AppRawNotification {
  AppRawNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.extURL,
    required this.data,
    required this.imageUrl,
  });
  int id;
  String title;
  String body;
  String? extURL;
  String data;
  String? imageUrl;

  AppRawNotification.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        title = newItem["title"],
        body = newItem["body"],
        extURL = newItem["extURL"],
        data = newItem["data"],
        imageUrl = newItem["imageUrl"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "extURL": extURL,
      "data": data,
      "imageUrl": imageUrl,
    };
  }
}
