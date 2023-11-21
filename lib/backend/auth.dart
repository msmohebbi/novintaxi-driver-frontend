import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as htp;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/const.dart';

class Auth {
  final String _baseUrl = apiUrl;
  // final String _baseUrl =
  //     kIsWeb ? "http://127.0.0.1:8000" : "http://10.0.2.2:8000";

  Future<bool> requestPass(String userName) async {
    Uri url = Uri.parse("$_baseUrl/authentication/request_password");
    log(url.toString());
    var res = await htp.post(
      url,
      body: {"username": userName},
      // headers: {"Access-Control-Allow-Origin": "*"},
      // headers: {"Authorization": accessToken},
    ).timeout(const Duration(seconds: 10));
    log(res.body);
    log("requestPass ${res.statusCode}");
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> signUp(String name, String userName) async {
    Uri url = Uri.parse("$_baseUrl/auth/users/");
    log(url.toString());
    log(userName);
    var res = await htp.post(
      url,
      body: {
        "name": name,
        "username": userName,
        "role": "driver",
      },
      // headers: {"Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"},
    ).timeout(const Duration(seconds: 10));
    // log(res.body);
    // log(res.statusCode);
    log("signUp ${res.statusCode}");

    var ret = Map<String, dynamic>.from(json.decode(res.body));
    ret.addAll({"status": res.statusCode});
    return ret;
  }

  Future<Map<String, String>> login(String userName, String password) async {
    Uri url = Uri.parse("$_baseUrl/auth/jwt/create/");
    // log(url);
    var res = await htp.post(
      url,
      body: {"username": userName, "password": password},
      // headers: {"Access-Control-Allow-Origin": "*"}
      // headers: {"Api-Key": "service.lhCi9CxMh9mf07FXTBMYAYBo0BaXToba0VRdRVhk"},
    ).timeout(const Duration(seconds: 10));

    // log(res.body);
    // log(res.statusCode);
    log("login ${res.statusCode}");

    if (res.statusCode == 200) {
      String refresh = json.decode(res.body)["refresh"];
      String access = json.decode(res.body)["access"];
      return <String, String>{"refresh": refresh, "access": access};
    }
    return <String, String>{"detail": json.decode(res.body)["detail"]};
  }

  Future<String> verifyTokenInternet(accessToken) async {
    Uri url = Uri.parse("$_baseUrl/auth/jwt/verify/");
    log(url.toString());
    try {
      var res = await htp.post(
        url,
        body: {"token": accessToken},
        // headers: {"Access-Control-Allow-Origin": "*"},
      );
      log("verifyToken ${res.statusCode}");

      if (res.statusCode == 200) {
        return "ok";
      }
    } catch (_) {
      return "nointernet";
    }
    return "nok";
  }

  Future<String?> checkAndFixAccesToken(bool knowThatAccessIsExpired) async {
    var prefs = await SharedPreferences.getInstance();
    bool isTokenVerified = false;
    var refresToken = prefs.getString("refresh");
    if ((refresToken ?? "") == "") {
      await prefs.setString("refresh", "");
      await prefs.setString("access", "");
      return null;
    }
    if (!knowThatAccessIsExpired) {
      var accessToken = prefs.getString("access");
      log(accessToken.toString());
      isTokenVerified = !Jwt.isExpired(accessToken!);
    }
    if (!isTokenVerified) {
      log("newAccessNeeded");
      var newAccessToken = await tokenRefresh(refresToken);
      if (newAccessToken == "nointernet") {
        return "nointernet";
      }
      if (newAccessToken != "") {
        await prefs.setString("access", newAccessToken);
        return null;
      } else {
        await prefs.setString("refresh", "");
        await prefs.setString("access", "");
        return "refreshTokenError";
      }
    } else {
      log("newAccess Not Needed");
      return null;
    }
  }

  Future<String> tokenRefresh(refreshToken) async {
    Uri url = Uri.parse("$_baseUrl/auth/jwt/refresh/");
    // log(url);
    try {
      var res = await htp.post(
        url,
        body: {"refresh": refreshToken},
        // headers: {"Access-Control-Allow-Origin": "*"},
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)["access"];
      }
    } catch (_) {
      return "nointernet";
    }
    return "";
  }
}
