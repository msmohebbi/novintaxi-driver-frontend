import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:novintaxidriver/backend/map.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:novintaxidriver/backend/api.dart';
import 'package:novintaxidriver/backend/api_endpoints.dart';
import 'package:novintaxidriver/models/driver_model.dart';
import 'package:novintaxidriver/models/driverprofile_model.dart';
import 'package:novintaxidriver/models/drivervehicle_model.dart';
import '../models/location_model.dart';
import '../models/transport_model.dart';

class DriverData with ChangeNotifier {
  DriverData() {
    _timer = Timer.periodic(
      const Duration(seconds: 120),
      (timer) {
        if ((cDriver?.isAvailable ?? false) && (cDriver?.isVerify ?? false)) {
          sendLiveLocation();
        }
      },
    );
    initilizeDriverData();
  }
  Timer? _timer;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  initilizeDriverData() async {
    await checkDriverData();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> checkDriverData() async {
    // await changeisEditRequested(false);
    await getDriver();
    await getDriverProfile();
    await getDriverVehicle();
    await initializeisEditRequested();
    if (cDriver != null && cDriverProfile != null && cDriverVehicle != null) {
      _isDataComplete = true;
    }
    notifyListeners();
  }

  clearDriverData() {
    _cDriver = null;
    _cDriverProfile = null;
    _cDriverVehicle = null;
    _isInitialized = false;
    notifyListeners();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  setpageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  Future<bool> ensureInitialize() async {
    while (true) {
      if (isInitialized) {
        return true;
      } else {
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isChangeAvailable = false;
  bool get isChangeAvailable => _isChangeAvailable;

  bool _isUpdatingProfile = false;
  bool get isUpdatingProfile => _isUpdatingProfile;

  bool get isEditRequested => _isEditRequested;
  bool _isEditRequested = false;
  initializeisEditRequested() async {
    var prefs = await SharedPreferences.getInstance();
    _isEditRequested = prefs.getBool('isEditRequested') ?? false;
    if (isEditRequested) {
      setDriverFieldsDefaultValue();
    }
    notifyListeners();
  }

  setDriverFieldsDefaultValue() {
    nameController.text = cDriver?.name ?? '';
    _selectedSexualTypes = cDriver?.gender;
    addressController.text = cDriverProfile?.address ?? '';
    postalController.text = cDriverProfile?.postalCode ?? '';
    melliCodeController.text = cDriver?.nationalId ?? '';
    govahiCodeController.text = cDriverProfile?.carLicenseId ?? '';
    _govahiExpDate = cDriverProfile?.carLicenseExpireDate;
    vehicleModel.text = cDriverVehicle?.vehicleName ?? '';
    vehicleColor.text = cDriverVehicle?.vehicleColor ?? '';
    vehiclePelak.text = cDriverVehicle?.vehicleLicense ?? '';
    vehicleCartBackNo.text = cDriverVehicle?.vin ?? '';
    notifyListeners();
  }

  changeisEditRequested(bool newVal) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEditRequested', newVal);
    initializeisEditRequested();
  }

  bool get isDataComplete => _isDataComplete;
  bool _isDataComplete = false;

  AppLocation? _originLocation;
  AppLocation? get originLocation => _originLocation;
  setoriginLocation(AppLocation? neworiginLocation) {
    _originLocation = neworiginLocation;
    notifyListeners();
  }

  clearImages() {
    _personalImage = null;
    _melliFrontImage = null;
    _melliBackImage = null;
    _govahiFrontImage = null;
    _govahiBackImage = null;
    _vehicleCartBackImage = null;
    _vehicleCartFrontImage = null;
    _vehicleImage1 = null;
    _vehicleImage2 = null;
    _vehicleImage3 = null;
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
  AppDriver? get cDriver => _cDriver;
  AppDriver? _cDriver;

  AppDriverProfile? get cDriverProfile => _cDriverProfile;
  AppDriverProfile? _cDriverProfile;

  AppDriverVehicle? get cDriverVehicle => _cDriverVehicle;
  AppDriverVehicle? _cDriverVehicle;

  Future<void> getDriver() async {
    var fetchedData = await AppAPI().getWithoutPaginate(
      urlPath: EndPoints.drivers,
    );
    if (fetchedData.isNotEmpty) {
      _cDriver = AppDriver.fromMap(fetchedData[0]);
    }
  }

  Future<void> getDriverProfile() async {
    var fetchedData = await AppAPI().getWithoutPaginate(
      urlPath: EndPoints.driverProfiles,
    );
    if (fetchedData.isNotEmpty) {
      _cDriverProfile = AppDriverProfile.fromMap(fetchedData[0]);
    }
  }

  Future<void> getDriverVehicle() async {
    var fetchedData = await AppAPI().getWithoutPaginate(
      urlPath: EndPoints.driverVehicles,
    );
    if (fetchedData.isNotEmpty) {
      _cDriverVehicle = AppDriverVehicle.fromMap(fetchedData[0]);
    }
  }

  Future<void> createDriver() async {
    _isUpdatingProfile = true;
    notifyListeners();
    // 1st Request
    var driver = AppDriver(
      id: 1,
      user: 1,
      name: nameController.text.trim(),
      nationalId: melliCodeController.text.trim(),
      gender: selectedSexualTypes!,
    );
    var driverDataMap = driver.toMap();
    Map<String, File> driverFileMap = {};
    if (personalImage != null) {
      driverFileMap['personal_image'] = personalImage!;
    }
    if (cDriver != null) {
      await AppAPI().update(
        EndPoints.drivers,
        cDriver!.id,
        driverDataMap,
        driverFileMap.isNotEmpty ? driverFileMap : null,
        true,
      );
    } else {
      await AppAPI().create(
        EndPoints.drivers,
        driverDataMap,
        driverFileMap,
      );
    }
    // 2nd Request
    var driverProfile = AppDriverProfile(
      id: 1,
      driver: driver.id,
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
    Map<String, File> driverProfileFileMap = {};
    if (melliFrontImage != null) {
      driverProfileFileMap['national_card_image'] = melliFrontImage!;
    }
    if (melliBackImage != null) {
      driverProfileFileMap['national_card_image_back'] = melliBackImage!;
    }
    if (govahiFrontImage != null) {
      driverProfileFileMap['car_license_image'] = govahiFrontImage!;
    }
    if (govahiBackImage != null) {
      driverProfileFileMap['car_license_image_back'] = govahiBackImage!;
    }
    if (cDriverProfile != null) {
      await AppAPI().update(
        EndPoints.driverProfiles,
        cDriverProfile!.id,
        driverProfileDataMap,
        driverProfileFileMap.isNotEmpty ? driverProfileFileMap : null,
        true,
      );
    } else {
      await AppAPI().create(
        EndPoints.driverProfiles,
        driverProfileDataMap,
        driverProfileFileMap,
      );
    }
    // 3nd Request
    var driverVehicle = AppDriverVehicle(
      id: 1,
      driver: driver.id,
      vehicleName: vehicleModel.text.trim(),
      vehicleColor: vehicleColor.text.trim(),
      vehicleLicense: vehiclePelak.text.trim(),
      vin: vehicleCartBackNo.text.trim(),
    );
    Map<String, File> driverVehicleFileMap = {};
    if (vehicleCartFrontImage != null) {
      driverVehicleFileMap['vehicle_card_image'] = vehicleCartFrontImage!;
    }
    if (vehicleCartBackImage != null) {
      driverVehicleFileMap['vehicle_card_image_back'] = vehicleCartBackImage!;
    }
    if (vehicleImage1 != null) {
      driverVehicleFileMap['vehicle_image'] = vehicleImage1!;
    }
    if (vehicleImage2 != null) {
      driverVehicleFileMap['vehicle_image_back'] = vehicleImage2!;
    }
    if (vehicleImage3 != null) {
      driverVehicleFileMap['vehicle_image_in'] = vehicleImage3!;
    }
    var driverVehicleDataMap = driverVehicle.toMap();
    if (cDriverVehicle != null) {
      await AppAPI().update(
        EndPoints.driverVehicles,
        cDriverVehicle!.id,
        driverVehicleDataMap,
        driverVehicleFileMap.isNotEmpty ? driverVehicleFileMap : null,
        true,
      );
    } else {
      await AppAPI().create(
        EndPoints.driverVehicles,
        driverVehicleDataMap,
        driverVehicleFileMap,
      );
    }
    await checkDriverData();
    await changeisEditRequested(false);
    clearImages();
    _isUpdatingProfile = false;
    notifyListeners();
  }

  changeIsAvailabe() async {
    _isChangeAvailable = true;
    notifyListeners();
    var newTransportData = await AppAPI().update(
      '${EndPoints.drivers}/${cDriver?.id}/change_available',
      null,
      {},
      null,
      false,
    );
    if (newTransportData.isNotEmpty) {
      _cDriver = AppDriver.fromMap(newTransportData);
    }

    _isChangeAvailable = false;
    notifyListeners();
  }

// ---------------------------------- LiveLocation ------------------------

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    try {
      var currLocation = await Geolocator.getCurrentPosition();

      return currLocation;
    } catch (_) {
      return null;
    }
  }

  Future<void> sendLiveLocation() async {
    // Start Live Location
    var currLocation = await getCurrentLocation();

    if (currLocation != null) {
      var currentLatLng = LatLng(currLocation.latitude, currLocation.longitude);
      // Start Live Location GeoCoding
      var revGeo = await MapBackend()
          .reverseGeocoding(currLocation.latitude, currLocation.longitude);
      if (revGeo.isNotEmpty) {
        var newLocation = AppLocation.fromMap(revGeo);
        // Start Live Location Updating
        await AppAPI().create(
          'driver/driver_live_location',
          {
            'lat': currentLatLng.latitude,
            'lng': currentLatLng.longitude,
            'desc': newLocation.desc,
            'city': newLocation.city,
          },
          null,
        );
      }
    }
  }
}
