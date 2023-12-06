class AppVehicle {
  AppVehicle({
    required this.id,
    required this.name,
    required this.coefficient,
    required this.image,
    required this.order,
  });
  int id;
  String name;
  num coefficient;
  String image;
  int order;
  AppVehicle.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        name = newItem["name"],
        coefficient = newItem["coefficient"],
        image = newItem["image"],
        order = newItem["order"] {}
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "coefficient": coefficient,
      "image": image,
      "order": order,
    };
  }
}
