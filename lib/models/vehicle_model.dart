class AppVehicle {
  AppVehicle({
    required this.id,
    required this.name,
    required this.image,
    required this.coefficient,
  });
  int id;
  String name;
  String image;
  double coefficient;
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "coefficient": coefficient,
    };
  }

  AppVehicle.fromMap(Map<String, dynamic> newLocation)
      : id = newLocation["id"],
        name = newLocation["name"],
        image = newLocation["image"],
        coefficient = newLocation["coefficient"];
}
