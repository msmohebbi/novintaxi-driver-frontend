class AppDriverVehicle {
  AppDriverVehicle({
    required this.id,
    required this.driver,
    required this.vehicle_name,
    required this.vehicle_color,
    required this.vehicle_license,
    required this.vin,
    this.vehicle_card_image,
    this.vehicle_card_image_back,
    this.vehicle_image,
    this.vehicle_image_back,
    this.vehicle_image_in,
  });
  int id;
  String driver;
  String vehicle_name;
  String vehicle_color;
  String vehicle_license;
  String vin;
  String? vehicle_card_image;
  String? vehicle_card_image_back;
  String? vehicle_image;
  String? vehicle_image_back;
  String? vehicle_image_in;
  AppDriverVehicle.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        driver = newItem["driver"],
        vehicle_name = newItem["vehicle_name"],
        vehicle_color = newItem["vehicle_color"],
        vehicle_license = newItem["vehicle_license"],
        vin = newItem["vin"],
        vehicle_card_image = newItem["vehicle_card_image"],
        vehicle_card_image_back = newItem["vehicle_card_image_back"],
        vehicle_image = newItem["vehicle_image"],
        vehicle_image_back = newItem["vehicle_image_back"],
        vehicle_image_in = newItem["vehicle_image_in"] {}
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "driver": driver,
      "vehicle_name": vehicle_name,
      "vehicle_color": vehicle_color,
      "vehicle_license": vehicle_license,
      "vin": vin,
      "vehicle_card_image": vehicle_card_image,
      "vehicle_card_image_back": vehicle_card_image_back,
      "vehicle_image": vehicle_image,
      "vehicle_image_back": vehicle_image_back,
      "vehicle_image_in": vehicle_image_in,
    };
  }
}
