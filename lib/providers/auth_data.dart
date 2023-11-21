import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/auth.dart';

// signOutForEntry() async {
//   var prefs = await SharedPreferences.getInstance();
//   await prefs.setString("cuserPhone", "");
//   await prefs.setString("cuserFarsiName", "");
//   await prefs.setString("cuserLatinName", "");
//   await prefs.setInt("cuserID", -1);
//   await prefs.setString("cuserRole", "");
//   await prefs.setString("refresh", "");
//   await prefs.setString("access", "");
// }

class AuthData with ChangeNotifier {
  AuthData() {
    initializeAuthData();
  }

  bool _isNoInternet = false;
  bool get isNoInternet => _isNoInternet;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  initializeAuthData() async {
    var prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString("access") ?? "";
    _refreshToken = prefs.getString("refresh") ?? "";
    if (accessToken != "") {
      var isExpired = Jwt.isExpired(accessToken);
      if (isExpired) {
        String? checkString = await Auth().checkAndFixAccesToken(true);
        if (checkString == "refreshTokenError") {
          signOut();
          _isAuthenticated = false;
          _isInitialized = true;
          notifyListeners();

          return;
        } else if (checkString == "nointernet") {
          _isNoInternet = true;
          notifyListeners();
          return;
        } else {
          _accessToken = prefs.getString("access") ?? "";
        }
      }
      _isAuthenticated = true;
      _isInitialized = true;
      notifyListeners();
      return;
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future saveCredentials(String refreshToken, String accessToken) async {
    var prefs = await SharedPreferences.getInstance();
    _refreshToken = refreshToken;
    _accessToken = accessToken;
    await prefs.setString("refresh", refreshToken);
    await prefs.setString("access", accessToken);
    _isAuthenticated = true;
    notifyListeners();
  }

  signOut() async {
    _refreshToken = "";
    _accessToken = "";
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("refresh", "");
    await prefs.setString("access", "");
    _isAuthenticated = false;
    prefs.clear();
    notifyListeners();
  }

  String _refreshToken = "";
  String? get refreshToken => _refreshToken;
  String _accessToken = "";
  String get accessToken => _accessToken;

  int _lastSmsSend = 0;
  int get lastSmsSend => _lastSmsSend;
  setLastSmsSend(int newDate) async {
    _lastSmsSend = newDate;
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt("lastSmsSend", newDate);
    notifyListeners();
  }

  setUserTempPhone(newUserTempPhone) async {
    _cuserTempPhone = newUserTempPhone;
    notifyListeners();
  }

  String _cuserTempPhone = "";
  String get cuserTempPhone => _cuserTempPhone;
}
