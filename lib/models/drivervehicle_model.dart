import 'package:transportationdriver/models/driver_model.dart';

class AppDriverVehicle {
  AppDriverVehicle({
    required this.id,
    required this.driver,
    required this.vehicleName,
    required this.vehicleColor,
    required this.vehicleLicense,
    required this.vin,
    this.vehicleCardImageFront = '',
    this.vehicleCardImageBack = '',
    this.vehicleImageFront = '',
    this.vehicleImageBack = '',
    this.vehicleImageIn = '',
  });
  int id;
  AppDriver driver;
  String vehicleName;
  String vehicleColor;
  String vehicleLicense;
  String vin;
  String vehicleCardImageFront;
  String vehicleCardImageBack;
  String vehicleImageFront;
  String vehicleImageBack;
  String vehicleImageIn;
  AppDriverVehicle.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        driver = newItem["driver"],
        vehicleName = newItem["vehicle_name"],
        vehicleColor = newItem["vehicle_color"],
        vehicleLicense = newItem["vehicle_license"],
        vin = newItem["vin"],
        vehicleCardImageFront = newItem["vehicle_card_image"],
        vehicleCardImageBack = newItem["vehicle_card_image_back"],
        vehicleImageFront = newItem["vehicle_image"],
        vehicleImageBack = newItem["vehicle_image_back"],
        vehicleImageIn = newItem["vehicle_image_in"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "driver": driver.id,
      "vehicle_name": vehicleName,
      "vehicle_color": vehicleColor,
      "vehicle_license": vehicleLicense,
      "vin": vin,
    };
  }
}
