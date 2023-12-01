import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportationdriver/backend/api.dart';
import 'package:transportationdriver/backend/api_endpoints.dart';
import 'package:transportationdriver/models/driver_transport_model.dart';
import 'package:transportationdriver/models/transport_model.dart';

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

  List<AppTransport> get allTransports => _allTransports;
  List<AppTransport> _allTransports = [];

  List<AppDriverTransport> get driverTransports => _driverTransports;
  List<AppDriverTransport> _driverTransports = [];

  List<String> get ignoredTransports => _ignoredTransports;
  List<String> _ignoredTransports = [];

  Future<void> getTransports() async {
    var listofmap = await AppAPI()
        .getWithoutPaginate(urlPath: '${EndPoints.transports}/get_in_process');
    _allTransports = [];
    for (var newAppTransport in listofmap) {
      var newElement = AppTransport.fromMap(newAppTransport);
      if (ignoredTransports
          .where((element) => element == newElement.id.toString())
          .isEmpty) {
        _allTransports.add(newElement);
      }
    }
    notifyListeners();
  }

  Future<void> getDriverTransports() async {
    var listofmap =
        await AppAPI().getWithoutPaginate(urlPath: EndPoints.driverTransports);
    _driverTransports = [];
    for (var newAppTransport in listofmap) {
      var newElement = AppDriverTransport.fromMap(newAppTransport);

      _driverTransports.add(newElement);
    }
    notifyListeners();
  }

  Future<void> confirmTransport(AppTransport cTransport) async {
    await AppAPI().update(
      '${EndPoints.transports}/driver_confirm',
      cTransport.id,
      {},
      null,
    );
    await getDriverTransports();
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
