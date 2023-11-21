class AppClient {
  AppClient({
    required this.name,
    required this.phone,
  });
  String name;
  String phone;
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
    };
  }

  AppClient.fromMap(Map<String, dynamic> newClient)
      : phone = newClient["phone"],
        name = newClient["name"];
}
