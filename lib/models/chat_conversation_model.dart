class AppChatCoversation {
  AppChatCoversation({
    required this.id,
    required this.name,
  });
  int id;
  String name;

  AppChatCoversation.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        name = newItem["name"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
