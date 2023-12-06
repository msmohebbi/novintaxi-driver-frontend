import 'vehicle_type_model.dart';

class AppDriver {
  AppDriver({
    required this.id,
    required this.user,
    required this.name,
    required this.national_id,
    required this.gender,
    this.vehicle_type,
    required this.is_available,
    required this.is_disable,
    this.personal_image,
    required this.is_verify,
  });
  int id;
  String user;
  String name;
  String national_id;
  String gender;
  AppVehicleType? vehicle_type;
  bool is_available;
  bool is_disable;
  String? personal_image;
  bool is_verify;
  AppDriver.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        user = newItem["user"],
        name = newItem["name"],
        national_id = newItem["national_id"],
        gender = newItem["gender"],
        vehicle_type = AppVehicleType.fromMap(newItem["vehicle_type"]),
        is_available = newItem["is_available"],
        is_disable = newItem["is_disable"],
        personal_image = newItem["personal_image"],
        is_verify = newItem["is_verify"] {}
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "user": user,
      "name": name,
      "national_id": national_id,
      "gender": gender,
      "vehicle_type": vehicle_type!.toMap(),
      "is_available": is_available,
      "is_disable": is_disable,
      "personal_image": personal_image,
      "is_verify": is_verify,
    };
  }
}
