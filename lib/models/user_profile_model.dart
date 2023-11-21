class AppUserProfile {
  AppUserProfile({
    required this.id,
    required this.userId,
    required this.username,
    required this.name,
    required this.image,
  });
  int id;
  int userId;
  String username;
  String name;
  String? image;

  AppUserProfile.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        userId = newItem["user_id"],
        username = newItem["username"],
        name = newItem["name"],
        image = newItem["image"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "user_id": userId,
      "username": username,
      "name": name,
      "image": image,
    };
  }
}
