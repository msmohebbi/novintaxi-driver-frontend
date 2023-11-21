import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingData with ChangeNotifier {
  SettingData() {
    initializeSettinData();
  }

  int _authPageIndex = 0;
  int get authPageIndex => _authPageIndex;
  void setauthPageIndex(newIndex) {
    _authPageIndex = newIndex;
    notifyListeners();
  }

  final List<int> _bnbStack = [0];
  int _bnbIndex = 0;
  int get bnbIndex => _bnbIndex;
  void setbnbIndex(newIndex) {
    _bnbIndex = newIndex;

    if (_bnbStack.contains(newIndex)) {
      _bnbStack.removeWhere((element) => element == newIndex);
    }
    _bnbStack.add(newIndex);
    notifyListeners();
  }

  bool backbnbIndex() {
    if (_bnbStack.length == 1) {
      return true;
    } else {
      _bnbStack.removeLast();
      setbnbIndex(_bnbStack.last);
      return false;
    }
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  initializeSettinData() async {
    var prefs = await SharedPreferences.getInstance();

    bool? checkisDark = prefs.getBool("isDark");
    if (checkisDark == null) {
      await prefs.setBool("isDark", false);
      _isdark = false;
      notifyListeners();
    } else {
      _isdark = checkisDark;
      notifyListeners();
    }
    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    bool? checkislogin = prefs.getBool("isLogin");
    if (checkislogin == null) {
      prefs.setBool("isLogin", true).then((value) => _isLogin = value);
    }

    _isInitialized = true;
    notifyListeners();
  }

  bool _isTile = true;
  bool get isTile => kIsWeb ? true : _isTile;
  changeIsTile() {
    _isTile = !isTile;
    notifyListeners();
  }

  bool _isLogin = true;
  bool get isLogin => _isLogin;
  void changeIsLogin(bool newVal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogin = newVal;
    prefs.setBool("isLogin", !newVal);
    notifyListeners();
  }

  bool _isdark = false;
  bool get isDark => _isdark;
  void changeIsDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isdark = prefs.getBool("isDark") ?? false;
    _isdark = !isDark;
    prefs.setBool("isDark", _isdark);

    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
