import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as htp;

import '../const/const.dart';
import 'auth.dart';

class AppAPI {
  final String _baseUrl = apiUrl;

  // kIsWeb ? "http://127.0.0.1:8000" : "http://10.0.2.2:8000";
  Future<bool> checkAccess() async {
    var prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString("access");
    if (accessToken != "" && accessToken != null) {
      bool isExp = true;
      isExp = true;
      try {
        isExp = Jwt.isExpired(accessToken);
      } catch (_) {}
      if (isExp) {
        await Auth().checkAndFixAccesToken(true);
      }
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> getPaginate(
      {required String urlPath, String? queryParam, int? page}) async {
    var prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        "$_baseUrl/$urlPath/?${queryParam != null ? "$queryParam&" : ""}page=${page ?? 1}");
    int maxTry = 2;
    bool isFinish = false;
    int currentTries = 0;
    while (maxTry >= currentTries && !isFinish) {
      currentTries += 1;
      var hasAccess = await checkAccess();
      var accessToken = prefs.getString("access");
      // print(accessToken);
      var res = await htp.get(
        url,
        headers: hasAccess ? {"Authorization": "JWT $accessToken"} : {},
      );
      log(url.toString());
      log("get  $urlPath ${page ?? 1} ${res.statusCode}");

      if (res.statusCode == 401) {
        isFinish = false;
        await Auth().checkAndFixAccesToken(true);
      } else {
        isFinish = true;
        if (res.statusCode == 200) {
          return json.decode((utf8.decode(res.bodyBytes)));
        }
      }
    }
    return {};
  }

  Future<List<dynamic>> getWithoutPaginate({
    required String urlPath,
    String? queryParam,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        "$_baseUrl/$urlPath/?${queryParam != null ? "$queryParam&" : ""}");
    int maxTry = 2;
    bool isFinish = false;
    int currentTries = 0;
    while (maxTry >= currentTries && !isFinish) {
      currentTries += 1;
      var hasAccess = await checkAccess();
      var accessToken = prefs.getString("access");
      var res = await htp.get(
        url,
        headers: hasAccess ? {"Authorization": "JWT $accessToken"} : {},
      );
      print(url.toString());
      print("get  $urlPath  ${res.statusCode}");

      if (res.statusCode == 401) {
        isFinish = false;
        await Auth().checkAndFixAccesToken(true);
      } else {
        isFinish = true;
        if (res.statusCode == 200) {
          return json.decode((utf8.decode(res.bodyBytes)));
        }
      }
    }
    return [];
  }

  Future<dynamic> get(String urlPath, dynamic id,
      {String? secondryUrlPath}) async {
    var prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        "$_baseUrl/$urlPath/$id${secondryUrlPath != null ? '/$secondryUrlPath/' : '/'}");
    bool isFinish = false;
    int maxTry = 2;
    int currentTries = 0;
    while (maxTry >= currentTries && !isFinish) {
      currentTries += 1;
      var hasAccess = await checkAccess();
      var accessToken = prefs.getString("access");
      var res = await htp.get(
        url,
        headers: hasAccess
            ? {
                "Authorization": "JWT $accessToken",
              }
            : {},
      );
      log("$url ${res.statusCode}");
      if (res.statusCode == 401) {
        isFinish = false;
        await Auth().checkAndFixAccesToken(true);
      } else {
        isFinish = true;
        if (res.statusCode == 200) {
          return json.decode((utf8.decode(res.bodyBytes)));
        }
      }
    }
    return {};
  }

  Future<Map<String, dynamic>> create(String urlPath,
      Map<String, dynamic> dataMap, Map<String, File>? filesMap) async {
    var prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$_baseUrl/$urlPath/");
    bool isFinish = false;
    int maxTry = 2;
    int currentTries = 0;
    while (maxTry >= currentTries && !isFinish) {
      currentTries += 1;
      var hasAccess = await checkAccess();
      var accessToken = prefs.getString("access");
      if (filesMap == null) {
        var response = await htp.post(
          url,
          body: json.encode(dataMap),
          headers: hasAccess
              ? {
                  'Content-Type': 'application/json',
                  "Authorization": "JWT $accessToken",
                }
              : {},
        );
        print(utf8.decode(response.bodyBytes));
        if (response.statusCode == 401) {
          isFinish = false;
          await Auth().checkAndFixAccesToken(true);
        } else {
          isFinish = true;
          print("create $urlPath ${response.statusCode}");
          if (response.statusCode == 201) {
            return json.decode((utf8.decode(response.bodyBytes)));
          }
        }
      } else {
        var request = htp.MultipartRequest('POST', url)
          ..headers.addAll(
            hasAccess
                ? {
                    "Authorization": "JWT $accessToken",
                  }
                : {},
          );
        for (var key in dataMap.keys) {
          request.fields[key] = (dataMap[key] is Map)
              ? json.encode(dataMap[key])
              : dataMap[key].toString();
        }

        for (var key in filesMap.keys) {
          request.files
              .add(await htp.MultipartFile.fromPath(key, filesMap[key]!.path));
        }

        log(request.fields.toString());
        var res = await request.send();
        if (res.statusCode == 401) {
          isFinish = false;
          await Auth().checkAndFixAccesToken(true);
        } else {
          isFinish = true;
          var response = await htp.Response.fromStream(res);
          // log(utf8.decode(response.bodyBytes));
          print("create $urlPath ${res.statusCode}");
          if (res.statusCode == 201) {
            return json.decode((utf8.decode(response.bodyBytes)));
          }
        }
      }
    }
    return {};
  }

  Future<Map<String, dynamic>> update(
    String urlPath,
    int? id,
    Map<String, dynamic> dataMap,
    Map<String, File>? filesMap,
    bool isPatch,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$_baseUrl/$urlPath/${id != null ? '$id/' : ''}");
    print(url);
    bool isFinish = false;
    int maxTry = 2;
    int currentTries = 0;
    Map<String, dynamic> finalMap = {};
    while (maxTry >= currentTries && !isFinish) {
      currentTries += 1;
      var hasAccess = await checkAccess();
      var accessToken = prefs.getString("access");
      late htp.Response res;
      if (isPatch) {
        res = await htp.patch(
          url,
          body: json.encode(dataMap),
          headers: hasAccess
              ? {
                  "Authorization": "JWT $accessToken",
                  'Content-Type': 'application/json'
                }
              : {
                  'Content-Type': 'application/json',
                },
        );
      } else {
        res = await htp.put(
          url,
          body: json.encode(dataMap),
          headers: hasAccess
              ? {
                  "Authorization": "JWT $accessToken",
                  'Content-Type': 'application/json'
                }
              : {
                  'Content-Type': 'application/json',
                },
        );
      }
      if (res.statusCode == 401) {
        isFinish = false;
        await Auth().checkAndFixAccesToken(true);
      } else {
        isFinish = true;
        print("update $urlPath ${res.statusCode}");
        print("update $urlPath ${res.body}");
        if (res.statusCode == 201 || res.statusCode == 200) {
          finalMap = json.decode(utf8.decode(res.bodyBytes));
          // return {
          //   "status": "$urlPath updated",
          //   "data": json.decode(utf8.decode(res.bodyBytes)),
          // };
        }
        if (res.statusCode == 204) {
          return {};
        }
      }

      if (filesMap != null) {
        print(filesMap);
        var request = htp.MultipartRequest('PATCH', url)
          ..headers.addAll(
            hasAccess
                ? {
                    "Authorization": "JWT $accessToken",
                  }
                : {},
          );

        // dataMap.forEach((key, value) {
        //   // request.fields[key] = json.encode(value).toString();
        //   if (value != null) {
        //     request.fields[key] = dataMap[key].toString();
        //   }
        // });

        for (var key in filesMap.keys) {
          request.files
              .add(await htp.MultipartFile.fromPath(key, filesMap[key]!.path));
        }
        var resFile = await request.send();
        if (res.statusCode == 401) {
          isFinish = false;
          await Auth().checkAndFixAccesToken(true);
        } else {
          isFinish = true;
          print("patch update file $urlPath ${res.statusCode}");
          if (resFile.statusCode == 201) {
            var response = await htp.Response.fromStream(resFile);
            return {
              "status": "$urlPath updated",
              "data": finalMap
                ..addAll(json.decode(utf8.decode(response.bodyBytes))),
            };
          }
          if (resFile.statusCode == 204) {
            return {};
          }
        }
      }
      return finalMap;
    }
    return {};
  }

  Future<Map<String, dynamic>> delete(String urlPath, int? id) async {
    var prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$_baseUrl/$urlPath/${id != null ? '$id/' : ''}");
    bool isFinish = false;
    int maxTry = 2;
    int currentTries = 0;
    while (maxTry >= currentTries && !isFinish) {
      currentTries += 1;
      var hasAccess = await checkAccess();
      var accessToken = prefs.getString("access");
      var res = await htp.delete(
        url,
        headers: hasAccess
            ? {
                "Authorization": "JWT $accessToken",
              }
            : {},
      );
      if (res.statusCode == 401) {
        isFinish = false;
        await Auth().checkAndFixAccesToken(true);
      } else {
        isFinish = true;
        log("delete $urlPath $id ${res.statusCode}");
        if (res.statusCode == 204) {
          return {"status": "$urlPath deleted"};
        }
      }
    }
    return {};
  }
}
