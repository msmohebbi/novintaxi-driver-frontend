import 'package:flutter/material.dart';
import 'package:transportationdriver/backend/api_endpoints.dart';

import '../backend/api.dart';
import '../models/faq_model.dart';

class FAQData with ChangeNotifier {
  FAQData() {
    initializeFAQData();
  }

  initializeFAQData() async {
    await getFAQs();
    _isInitialized = true;
  }

  deleteFAQData() {
    _allFAQs = [];
    _isInitialized = true;
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  getFAQs() async {
    var fetchedRes = await AppAPI().getWithoutPaginate(urlPath: EndPoints.faq);
    _allFAQs.clear();
    for (var newfaqData in fetchedRes) {
      var newFAQ = AppFAQ.fromMap(newfaqData);
      _allFAQs.add(newFAQ);
    }
    _isInitialized = true;
    notifyListeners();
  }

  List<AppFAQ> _allFAQs = [];
  List<AppFAQ> get allFAQs => _allFAQs;

  // SettingData() {}
}
