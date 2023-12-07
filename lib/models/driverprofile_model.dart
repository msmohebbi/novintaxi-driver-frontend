class AppDriverProfile {
  AppDriverProfile({
    required this.id,
    required this.driver,
    required this.nationalCardImageFront,
    required this.nationalCardImageBack,
    required this.address,
    required this.postalCode,
    required this.carLicenseId,
    required this.carLicenseExpireDate,
    required this.carLicenseImageFront,
    required this.carLicenseImageBack,
  });
  int id;
  int driver;
  String nationalCardImageFront;
  String nationalCardImageBack;
  String address;
  String postalCode;
  String carLicenseId;
  int carLicenseExpireDate;
  String carLicenseImageFront;
  String carLicenseImageBack;
  AppDriverProfile.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        driver = newItem["driver"],
        nationalCardImageFront = newItem["national_card_image"],
        nationalCardImageBack = newItem["national_card_image_back"],
        address = newItem["address"],
        postalCode = newItem["post_code"],
        carLicenseId = newItem["car_license_id"],
        carLicenseExpireDate = newItem["car_license_expire_date"],
        carLicenseImageFront = newItem["car_license_image"],
        carLicenseImageBack = newItem["car_license_image_back"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "address": address,
      "post_code": postalCode,
      "car_license_id": carLicenseId,
      "car_license_expire_date": carLicenseExpireDate,
    };
  }
}
