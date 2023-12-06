class AppDriverProfile {
  AppDriverProfile({
    required this.id,
    required this.driver,
    this.national_card_image,
    this.national_card_image_back,
    required this.address,
    required this.post_code,
    required this.car_license_id,
    this.car_license_image,
    this.car_license_image_back,
  });
  int id;
  String driver;
  String? national_card_image;
  String? national_card_image_back;
  String address;
  String post_code;
  String car_license_id;
  String? car_license_image;
  String? car_license_image_back;
  AppDriverProfile.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        driver = newItem["driver"],
        national_card_image = newItem["national_card_image"],
        national_card_image_back = newItem["national_card_image_back"],
        address = newItem["address"],
        post_code = newItem["post_code"],
        car_license_id = newItem["car_license_id"],
        car_license_image = newItem["car_license_image"],
        car_license_image_back = newItem["car_license_image_back"] {}
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "driver": driver,
      "national_card_image": national_card_image,
      "national_card_image_back": national_card_image_back,
      "address": address,
      "post_code": post_code,
      "car_license_id": car_license_id,
      "car_license_image": car_license_image,
      "car_license_image_back": car_license_image_back,
    };
  }
}
