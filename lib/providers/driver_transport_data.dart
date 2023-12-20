import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:novintaxidriver/backend/api.dart';
import 'package:novintaxidriver/backend/api_endpoints.dart';
import 'package:novintaxidriver/models/driver_transport_model.dart';
import 'package:novintaxidriver/models/transport_model.dart';

class DriverTransportData with ChangeNotifier {
  DriverTransportData() {
    initializeDriverTransportData();
    notifyListeners();
  }

  Future<void> initializeDriverTransportData() async {
    await getDriverTransports();
    await getIgnoredTransports();
    await getTransports();
    _isInitialized = true;
  }

  clearDriverTransportData() {
    _isInitialized = false;
    _allTransports = [];
    _driverTransports = [];
    _ignoredTransports = [];
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  int? get isConfirmingId => _isConfirmingId;
  int? _isConfirmingId;

  bool get isUpdating => _isUpdating;
  bool _isUpdating = false;

  bool get isCanceling => _isCanceling;
  bool _isCanceling = false;

  List<AppTransport> get allTransports => _allTransports;
  List<AppTransport> _allTransports = [];

  List<AppDriverTransport> get driverTransports => _driverTransports;
  List<AppDriverTransport> _driverTransports = [];
  List<AppDriverTransport> get activedriverTransports =>
      _driverTransports.where((element) => element.dateEnded == null && !element.isCanceled).toList();
  List<AppDriverTransport> get donedriverTransports => _driverTransports.where((element) => element.dateEnded != null).toList();
  List<AppDriverTransport> get canceleddriverTransports => _driverTransports.where((element) => element.isCanceled).toList();

  List<String> get ignoredTransports => _ignoredTransports;
  List<String> _ignoredTransports = [];

  Future<void> getTransports() async {
    var listofmap = await AppAPI().getWithoutPaginate(urlPath: '${EndPoints.transports}/get_in_process');
    _allTransports = [];
    for (var newAppTransport in listofmap) {
      var newElement = AppTransport.fromMap(newAppTransport);
      if (ignoredTransports.where((element) => element == newElement.id.toString()).isEmpty) {
        _allTransports.add(newElement);
      }
    }
    notifyListeners();
  }

  Future<void> getDriverTransports() async {
    var listofmap = await AppAPI().getWithoutPaginate(urlPath: EndPoints.driverTransports);
    _driverTransports = [];
    for (var newAppTransport in listofmap) {
      var newElement = AppDriverTransport.fromMap(newAppTransport);
      // log(newAppTransport['transport']?['geometry']?.toString() ?? 'nooo');
      _driverTransports.add(newElement);
    }
    notifyListeners();
  }

  Future<void> confirmTransport(AppTransport cTransport) async {
    _isConfirmingId = cTransport.id;
    notifyListeners();
    await AppAPI().update(
      '${EndPoints.transports}/${cTransport.id}/driver_confirm',
      null,
      {},
      null,
      false,
    );
    await getTransports();
    await getDriverTransports();
    _isConfirmingId = null;
    notifyListeners();
  }

  Future<void> updateDriverTransport(AppDriverTransport cDriverTransport) async {
    if (isUpdating) {
      return;
    }
    _isUpdating = true;
    notifyListeners();
    if (cDriverTransport.statusId < 3) {
      String? cEndPoint;
      var endpointList = [
        'arrive',
        'start',
        'end',
      ];
      cEndPoint = endpointList[cDriverTransport.statusId];
      await AppAPI().update(
        '${EndPoints.driverTransports}/${cDriverTransport.id}/$cEndPoint',
        null,
        {},
        null,
        false,
      );
    }
    await getDriverTransports();
    _isUpdating = false;
    notifyListeners();
  }

  Future<void> cancelDriverTransport(AppDriverTransport cDriverTransport) async {
    if (_isCanceling || _isUpdating) {
      return;
    }
    _isCanceling = true;
    notifyListeners();
    if (cDriverTransport.statusId < 3) {
      await AppAPI().update(
        '${EndPoints.driverTransports}/${cDriverTransport.id}/cancel',
        null,
        {},
        null,
        false,
      );
      await getDriverTransports();
    }
    _isCanceling = false;
    notifyListeners();
  }

  Future<void> getIgnoredTransports() async {
    var prefs = await SharedPreferences.getInstance();
    _ignoredTransports = prefs.getStringList('ignoredList') ?? [];
    notifyListeners();
  }

  Future<void> ignoreTransport(AppTransport cTransport) async {
    var prefs = await SharedPreferences.getInstance();
    _ignoredTransports.add(cTransport.id.toString());
    await prefs.setStringList('ignoredList', _ignoredTransports);
    _allTransports.removeWhere((element) => element.id == cTransport.id);
    notifyListeners();
  }
}
