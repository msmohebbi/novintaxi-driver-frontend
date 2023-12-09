import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../models/transport_model.dart';

import '../models/vehicle_type_model.dart';

import '../backend/api.dart';
import '../backend/api_endpoints.dart';
import '../models/user_location_model.dart';

class TransportData with ChangeNotifier {
  TransportData() {
    // getUserLocations();
    getVehicles();
    _isInitialized = true;
    notifyListeners();
  }

  clearTransportData() {
    _isInitialized = false;
    _userLocations = [];
    _allVehicles = [];
  }

  int _modalIndex = 0;
  int get modalIndex => _modalIndex;
  setModalIndex(int newIndex) {
    _modalIndex = newIndex;
    notifyListeners();
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isUpdatingTransport = false;
  bool get isUpdatingTransport => _isUpdatingTransport;

  AppLocation? _originLocation;
  AppLocation? get originLocation => _originLocation;
  setoriginLocation(AppLocation? neworiginLocation) {
    _originLocation = neworiginLocation;
    notifyListeners();
  }

  AppLocation? _targetLocation;
  AppLocation? get targetLocation => _targetLocation;
  settargetLocation(AppLocation? newtargetLocation) {
    _targetLocation = newtargetLocation;
    notifyListeners();
  }

  AppTransport? _cTransport;
  AppTransport? get cTransport => _cTransport;

  AppVehicleType? _selectedVehicle;
  AppVehicleType? get selectedVehicle => _selectedVehicle;
  setSelectedVehicle(AppVehicleType newVehicle) async {
    _isUpdatingTransport = true;
    notifyListeners();
    var newTransport = await AppAPI().update(
      EndPoints.transports,
      _cTransport!.id,
      {
        "vehicle": newVehicle.id,
        "partial": true,
      },
      null,
      false,
    );
    _cTransport = AppTransport.fromMap(newTransport);
    _selectedVehicle = allVehicles
        .where((element) => element.id == cTransport!.vehicle)
        .firstOrNull;
    _isUpdatingTransport = false;
    notifyListeners();
  }

  final Map<bool, String> _transportRoundTripTypes = {
    false: 'رفت',
    true: 'رفت و برگشت',
  };
  Map<bool, String> get transportRoundTripTypes => _transportRoundTripTypes;
  setcTransportRoundTrip(bool newValue) {
    _cTransport!.back = newValue;
    notifyListeners();
  }

  final Map<String, String> _transportTimeTypes = {
    'as_soon_as_possible': 'فوری',
    'scheduled': 'زمان بندی شده',
  };
  Map<String, String> get transportTimeTypes => _transportTimeTypes;
  setcTransportTime(String newValue) {
    _cTransport!.type = newValue;
    notifyListeners();
  }

  setcTransportDateScheduledDate(DateTime newDateTime) {
    if (_cTransport!.dateSchedule != null) {
      var currentDateTime =
          DateTime.fromMillisecondsSinceEpoch(_cTransport!.dateSchedule!);
      var finalDateTime = DateTime(
        newDateTime.year,
        newDateTime.month,
        newDateTime.day,
        currentDateTime.hour,
        currentDateTime.minute,
      );
      _cTransport!.dateSchedule = finalDateTime.millisecondsSinceEpoch;
    } else {
      _cTransport!.dateSchedule = newDateTime.millisecondsSinceEpoch;
    }
    notifyListeners();
  }

  setcTransportDateScheduledTime(TimeOfDay newTime) {
    var currentDateTime = DateTime.fromMicrosecondsSinceEpoch(0);
    if (_cTransport!.dateSchedule != null) {
      currentDateTime =
          DateTime.fromMillisecondsSinceEpoch(_cTransport!.dateSchedule!);
    }
    var finalDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      newTime.hour,
      newTime.minute,
    );
    _cTransport!.dateSchedule = finalDateTime.millisecondsSinceEpoch;
    notifyListeners();
  }

  changeMorePrice(int changeNum) {
    if (_cTransport!.morePrice + changeNum >= 0) {
      _cTransport!.morePrice = _cTransport!.morePrice + changeNum;
      notifyListeners();
    }
  }

  changeMoreTime(int changeNum) {
    if (_cTransport!.moreTime + changeNum >= 0) {
      _cTransport!.moreTime = _cTransport!.moreTime + changeNum;
      notifyListeners();
    }
  }

  changeAdultCount(int changeNum) {
    if (_cTransport!.adult + changeNum >= 0) {
      _cTransport!.adult = _cTransport!.adult + changeNum;
      notifyListeners();
    }
  }

  changeKidsCount(int changeNum) {
    if (_cTransport!.child + changeNum >= 0) {
      _cTransport!.child = _cTransport!.child + changeNum;
      notifyListeners();
    }
  }

  final Map<bool, String> _passengerTypes = {
    true: 'خودم',
    false: 'دیگری',
  };
  Map<bool, String> get passengerTypes => _passengerTypes;
  changePassengerIsMe(bool newPassengerIsMe) {
    _cPassengerIsMe = newPassengerIsMe;
    notifyListeners();
  }

  bool _cPassengerIsMe = true;
  bool get cPassengerIsMe => _cPassengerIsMe;

  final TextEditingController _clientNameController =
      TextEditingController(text: "");
  TextEditingController get clientNameController => _clientNameController;

  final TextEditingController _clientPhoneController =
      TextEditingController(text: "");
  TextEditingController get clientPhoneController => _clientPhoneController;

  changeclientName(String newVal) {
    _clientNameController.text = newVal;
    _cTransport!.passengerName = newVal;
    notifyListeners();
  }

  changeclientPhone(String newVal) {
    _clientPhoneController.text = newVal;
    _cTransport!.passengerPhone = newVal;
    notifyListeners();
  }

  changeAnimal(bool newVal) {
    _cTransport!.animal = newVal;
    notifyListeners();
  }

  changeExtraLoad(bool newVal) {
    _cTransport!.extraLoad = newVal;
    notifyListeners();
  }

  changeInvoice(bool newVal) {
    _cTransport!.invoice = newVal;
    notifyListeners();
  }

// ---------------------------------- Trannsport ------------------------
  createTransport() async {
    _isUpdatingTransport = true;
    notifyListeners();
    var originOD = {
      "location": originLocation?.toMap(),
      "isStart": true,
      "isEnd": false,
    };
    var targetOD = {
      "location": targetLocation?.toMap(),
      "isStart": true,
      "isEnd": false,
    };
    var newTransport = await AppAPI().create(
      EndPoints.transports,
      {
        "transport_ods": [
          originOD,
          targetOD,
        ]
      },
      null,
    );
    if (newTransport.isNotEmpty) {
      _cTransport = AppTransport.fromMap(newTransport);
      _selectedVehicle = allVehicles
          .where((element) => element.id == cTransport!.vehicle)
          .firstOrNull;
    }
    _isUpdatingTransport = false;
    notifyListeners();
  }

  updateTransport() async {
    _isUpdatingTransport = true;
    if (_cTransport == null) {
      return;
    }
    notifyListeners();
    var newTransportData = await AppAPI().update(
      EndPoints.transports,
      cTransport!.id,
      cTransport!.toMap(),
      null,
      false,
    );
    if (newTransportData.isNotEmpty) {
      _cTransport = AppTransport.fromMap(newTransportData);
      _selectedVehicle = allVehicles
          .where((element) => element.id == cTransport!.vehicle)
          .firstOrNull;
    }
    _isUpdatingTransport = false;
    notifyListeners();
  }

  Future<void> searchTransportDriver() async {
    _isUpdatingTransport = true;
    if (_cTransport == null) {
      return;
    }
    notifyListeners();
    var newTransportData = await AppAPI().update(
      '${EndPoints.transports}/${_cTransport!.id}/search_for_driver',
      null,
      {},
      null,
      false,
    );
    if (newTransportData.isNotEmpty) {
      _cTransport = AppTransport.fromMap(newTransportData);
    }
    _isUpdatingTransport = false;
    notifyListeners();
  }

  Future<void> cancelSearchTransportDriver() async {
    _isUpdatingTransport = true;
    if (_cTransport == null) {
      return;
    }
    notifyListeners();
    var newTransportData = await AppAPI().update(
      '${EndPoints.transports}/${_cTransport!.id}/cancel_search',
      null,
      {},
      null,
      false,
    );
    if (newTransportData.isNotEmpty) {
      _cTransport = AppTransport.fromMap(newTransportData);
    }
    _isUpdatingTransport = false;
    notifyListeners();
  }

// ---------------------------------- Vehicles ------------------------
  List<AppVehicleType> _allVehicles = [];
  List<AppVehicleType> get allVehicles => _allVehicles;

  getVehicles() async {
    var listofmap =
        await AppAPI().getWithoutPaginate(urlPath: EndPoints.vehicles);
    _allVehicles.clear();
    for (var newAppVehicleType in listofmap) {
      _allVehicles.add(AppVehicleType.fromMap(newAppVehicleType));
    }
    notifyListeners();
  }

// ---------------------------------- User Locations ------------------------
  List<AppUserLocation> _userLocations = [];
  List<AppUserLocation> get userLocations => _userLocations;

  getUserLocations() async {
    var listofmap = await AppAPI()
        .getWithoutPaginate(urlPath: "${EndPoints.transports}/userlocations");
    _userLocations.clear();
    for (var newUserLocation in listofmap) {
      _userLocations.add(AppUserLocation.fromMap(newUserLocation));
    }
    notifyListeners();
  }

  Future<void> addUserLocation(AppUserLocation newUserLocation) async {
    await AppAPI().create(
      "${EndPoints.transports}/userlocations",
      newUserLocation.toMap(),
      null,
    );
    await getUserLocations();
    notifyListeners();
  }
}
