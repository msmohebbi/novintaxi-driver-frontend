import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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
  setmelliFrontImage(File? newmelliFrontImage) {
    _melliFrontImage = newmelliFrontImage;
    notifyListeners();
  }

  File? _melliBackImage;
  File? get melliBackImage => _melliBackImage;
  setmelliBackImage(File? newmelliBackImage) {
    _melliBackImage = newmelliBackImage;
    notifyListeners();
  }

// Page 2
  final TextEditingController _givahiCodeController =
      TextEditingController(text: "");
  TextEditingController get givahiCodeController => _givahiCodeController;

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
}
