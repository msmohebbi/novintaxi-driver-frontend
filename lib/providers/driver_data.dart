import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:transportationdriver/backend/api.dart';
import 'package:transportationdriver/backend/api_endpoints.dart';
import 'package:transportationdriver/models/driver_model.dart';
import 'package:transportationdriver/models/driverprofile_model.dart';
import 'package:transportationdriver/models/drivervehicle_model.dart';
import '../models/location_model.dart';
import '../models/transport_model.dart';

class DriverData with ChangeNotifier {
  DriverData() {
    // getUserLocations();
    _isInitialized = true;
    notifyListeners();
  }

  clearDriverData() {
    _isInitialized = false;
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  setpageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isUpdatingProfile = false;
  bool get isUpdatingProfile => _isUpdatingProfile;

  AppLocation? _originLocation;
  AppLocation? get originLocation => _originLocation;
  setoriginLocation(AppLocation? neworiginLocation) {
    _originLocation = neworiginLocation;
    notifyListeners();
  }

  AppTransport? _cTransport;
  AppTransport? get cTransport => _cTransport;
// Page 0
  File? get personalImage => _personalImage;
  File? _personalImage;
  setpersonalImage(File? newImage) {
    _personalImage = newImage;
    notifyListeners();
  }

  final TextEditingController _nameController = TextEditingController(text: "");
  TextEditingController get nameController => _nameController;

  final TextEditingController _addressController =
      TextEditingController(text: "");
  TextEditingController get addressController => _addressController;

  final TextEditingController _postalController =
      TextEditingController(text: "");
  TextEditingController get postalController => _postalController;

  final List<String> _sexualTypes = [
    'مرد',
    'زن',
  ];
  List<String> get sexualTypes => _sexualTypes;
  String? _selectedSexualTypes;
  String? get selectedSexualTypes => _selectedSexualTypes;
  changeSexualTypes(String newSexualTypes) {
    _selectedSexualTypes = newSexualTypes;
    notifyListeners();
  }

// Page 1
  final TextEditingController _melliCodeController =
      TextEditingController(text: "");
  TextEditingController get melliCodeController => _melliCodeController;

  File? _melliFrontImage;
  File? get melliFrontImage => _melliFrontImage;
  setmelliFrontImage(File? newImage) {
    _melliFrontImage = newImage;
    notifyListeners();
  }

  File? _melliBackImage;
  File? get melliBackImage => _melliBackImage;
  setmelliBackImage(File? newImage) {
    _melliBackImage = newImage;
    notifyListeners();
  }

// Page 2
  final TextEditingController _govahiCodeController =
      TextEditingController(text: "");
  TextEditingController get govahiCodeController => _govahiCodeController;

  int? _govahiExpDate;
  int? get govahiExpDate => _govahiExpDate;
  String? get govahiExpDateString {
    if (_govahiExpDate != null) {
      Jalali? jalali = Jalali.fromDateTime(
          DateTime.fromMillisecondsSinceEpoch(govahiExpDate!));
      return jalali.formatFullDate();
    } else {
      return null;
    }
  }

  setgovahiExpDate(DateTime newDateTime) {
    _govahiExpDate = newDateTime.millisecondsSinceEpoch;
    notifyListeners();
  }

  File? _govahiFrontImage;
  File? get govahiFrontImage => _govahiFrontImage;
  setgovahiFrontImage(File? newImage) {
    _govahiFrontImage = newImage;
    notifyListeners();
  }

  File? _govahiBackImage;
  File? get govahiBackImage => _govahiBackImage;
  setgovahiBackImage(File? newImage) {
    _govahiBackImage = newImage;
    notifyListeners();
  }

// Page 3
  TextEditingController get vehicleModel => _vehicleModel;
  final TextEditingController _vehicleModel = TextEditingController(text: "");

  TextEditingController get vehicleColor => _vehicleColor;
  final TextEditingController _vehicleColor = TextEditingController(text: "");

  TextEditingController get vehiclePelak => _vehiclePelak;
  final TextEditingController _vehiclePelak = TextEditingController(text: "");

// Page 4
  TextEditingController get vehicleCartBackNo => _vehicleCartBackNo;
  final TextEditingController _vehicleCartBackNo =
      TextEditingController(text: "");

  File? get vehicleCartBackImage => _vehicleCartBackImage;
  File? _vehicleCartBackImage;
  setvehicleCartBackImage(File? newImage) {
    _vehicleCartBackImage = newImage;
    notifyListeners();
  }

  File? get vehicleCartFrontImage => _vehicleCartFrontImage;
  File? _vehicleCartFrontImage;
  setvehicleCartFrontImage(File? newImage) {
    _vehicleCartFrontImage = newImage;
    notifyListeners();
  }

  File? get vehicleImage1 => _vehicleImage1;
  File? _vehicleImage1;
  setvehicleImage1(File? newImage) {
    _vehicleImage1 = newImage;
    notifyListeners();
  }

  File? get vehicleImage2 => _vehicleImage2;
  File? _vehicleImage2;
  setvehicleImage2(File? newImage) {
    _vehicleImage2 = newImage;
    notifyListeners();
  }

  File? get vehicleImage3 => _vehicleImage3;
  File? _vehicleImage3;
  setvehicleImage3(File? newImage) {
    _vehicleImage3 = newImage;
    notifyListeners();
  }

  // ------------------ Connect to  backend ------------------------------
  Future<void> createDriver() async {
    _isUpdatingProfile = true;
    notifyListeners();
    // 1st Request
    var driver = AppDriver(
      id: 1,
      user: '1',
      name: nameController.text.trim(),
      nationalId: melliCodeController.text.trim(),
      gender: selectedSexualTypes!,
    );
    var driverDataMap = driver.toMap();
    var driverFileMap = {
      'personal_image': personalImage!,
    };
    await AppAPI().create(
      EndPoints.drivers,
      driverDataMap,
      driverFileMap,
    );
    // 2nd Request
    var driverProfile = AppDriverProfile(
      id: 1,
      driver: driver,
      nationalCardImageFront: '',
      nationalCardImageBack: '',
      address: addressController.text.trim(),
      postalCode: postalController.text.trim(),
      carLicenseId: govahiCodeController.text.trim(),
      carLicenseImageFront: '',
      carLicenseImageBack: '',
      carLicenseExpireDate: govahiExpDate!,
    );
    var driverProfileDataMap = driverProfile.toMap();
    var driverProfileFileMap = {
      "national_card_image": melliFrontImage!,
      "national_card_image_back": melliBackImage!,
      "car_license_image": govahiFrontImage!,
      "car_license_image_back": govahiBackImage!,
    };
    await AppAPI().create(
      EndPoints.driverProfiles,
      driverProfileDataMap,
      driverProfileFileMap,
    );
    // 3nd Request
    var driverVehicle = AppDriverVehicle(
      id: 1,
      driver: driver,
      vehicleName: vehicleModel.text.trim(),
      vehicleColor: vehicleColor.text.trim(),
      vehicleLicense: vehiclePelak.text.trim(),
      vin: vehicleCartBackNo.text.trim(),
    );
    var driverVehicleDataMap = driverVehicle.toMap();
    var driverVehicleFileMap = {
      "vehicle_card_image": vehicleCartFrontImage!,
      "vehicle_card_image_back": vehicleCartBackImage!,
      "vehicle_image": vehicleImage1!,
      "vehicle_image_back": vehicleImage2!,
      "vehicle_image_in": vehicleImage3!,
    };
    await AppAPI().create(
      EndPoints.driverVehicles,
      driverVehicleDataMap,
      driverVehicleFileMap,
    );
    _isUpdatingProfile = false;
    notifyListeners();
  }
}
