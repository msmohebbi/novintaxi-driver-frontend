import 'package:novintaxidriver/models/vehicle_type_model.dart';

class AppDriver {
  AppDriver({
    required this.id,
    required this.user,
    required this.name,
    required this.nationalId,
    required this.gender,
    this.vehicleType,
    this.isAvailable = false,
    this.isDisable = false,
    this.personalImage = '',
    this.isVerify = false,
    this.rate,
    this.verifyDesc,
  });
  int id;
  int user;
  String name;
  String nationalId;
  String gender;
  AppVehicleType? vehicleType;
  bool isAvailable;
  bool isDisable;
  String personalImage;
  bool isVerify;
  double? rate;
  String? verifyDesc;
  AppDriver.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        user = newItem["user"],
        name = newItem["name"],
        nationalId = newItem["national_id"],
        gender = newItem["gender"],
        vehicleType = newItem["vehicle_type"] != null
            ? AppVehicleType.fromMap(newItem["vehicle_type"])
            : null,
        isAvailable = newItem["is_available"],
        isDisable = newItem["is_disable"],
        personalImage = newItem["personal_image"],
        isVerify = newItem["is_verify"],
        rate = newItem["rate"],
        verifyDesc = newItem["verify_desc"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "national_id": nationalId,
      "gender": gender,
    };
  }
}
