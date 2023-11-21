import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/api.dart';
import '../backend/api_endpoints.dart';
import '../models/user_profile_model.dart';

class ProfileData with ChangeNotifier {
  void updater(authData) {
    if (authData.isAuthenticated) {
      initializeProfileData();
    }
    // else {
    //   clearProfileData();
    // }
  }

  initializeProfileData() async {
    await getProfile();
    _isInitialized = true;
    notifyListeners();
  }

  clearProfileData() async {
    _cUserProfile = null;
    notifyListeners();
  }

  getProfile({bool cached = !kIsWeb}) async {
    var prefs = await SharedPreferences.getInstance();
    late Map<String, dynamic> profileData;
    if (cached) {
      String targetData = prefs.getString("profile") ?? "";
      if (targetData == "") {
        profileData = {};
      } else {
        profileData = json.decode(targetData);
      }
    } else {
      profileData = await AppAPI().getPaginate(
        urlPath: "${EndPoints.profiles}/me",
      );
      prefs.setString("profile", json.encode(profileData));
    }
    if (profileData.isNotEmpty) {
      _cUserProfile = AppUserProfile.fromMap(profileData);
    }
    if (cached) {
      getProfile(cached: false);
    }
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  AppUserProfile? _cUserProfile;
  AppUserProfile? get cUserProfile => _cUserProfile;

//   Future<void> setProfileNames(
//       String latinName, String farsiName, BuildContext context) async {
//     await AppAPI().setProfileNames(latinName, farsiName);
//     // Phoenix.rebirth(context);
//     // _allProducts.add(newProduct);
//     await getProfile();
//   }

//   Future<void> setProfileImage(File file) async {
//     await AppAPI().setProfileImage(file);
//     await getProfile();
//   }

//   Future<void> deleteProfileImage() async {
//     await AppAPI().deleteProfileImage();
//     await getProfile();
//   }
// }
}
