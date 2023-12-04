// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../backend/api.dart';
import '../backend/api_endpoints.dart';
import '../models/notification_subscribe_model.dart';
import '../models/user_notification_model.dart';

class NotificationData with ChangeNotifier {
  void updater(authData) {
    if (authData.isAuthenticated) {
      initializeNotifications();
    } else {
      clearNotifications();
    }
  }

  Future<void> initializeNotifications() async {
    await getNotification();
    // var isDone = false;
    // while (!isDone) {
    //   try {
    if (Firebase.apps.isNotEmpty) {
      log("firebase onMassage Initialized");
      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        getNotification();
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
        getNotification();
      });
      // FirebaseMessaging.onBackgroundMessage((message) => getNotification());
      // isDone = true;
    }
    // } catch (_) {
    //   Future.delayed(const Duration(milliseconds: 500), () {});
    // }
    // }
    _isInitialized = true;
  }

  clearNotifications() {
    _allNotifications = [];
    _allNotificationSubscribes = [];
    _isInitialized = true;
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  getNotification() async {
    var fetchedRes = await AppAPI().getWithoutPaginate(
      urlPath: "${EndPoints.notification}/usernotifications",
    );
    _allNotifications.clear();
    for (var newCartData in fetchedRes) {
      var newNotications = AppUserNotification.fromMap(newCartData);
      _allNotifications.add(newNotications);
    }
    notifyListeners();
  }

  Future<void> readNotification(int notificatonId) async {
    var oldNotif =
        _allNotifications.firstWhere((element) => element.id == notificatonId);
    if (oldNotif.isRead == false) {
      var fetchedRes = await AppAPI().update(
          "${EndPoints.notification}/usernotifications/$notificationChoices/read",
          null,
          {},
          null);
      if (fetchedRes.isNotEmpty) {
        var indexx = _allNotifications.indexOf(oldNotif);
        _allNotifications.removeWhere((element) => element.id == notificatonId);
        _allNotifications.insert(
            indexx, AppUserNotification.fromMap(fetchedRes));
        notifyListeners();
      }
    }
  }

  Map<String, bool> getNotificationsTypes() {
    Map<String, bool> returnedMap = {};
    for (var element in _allNotifications) {
      String newType = element.notification.type;
      bool newTypeIsRead = element.isRead;
      if (!returnedMap.keys.contains(newType)) {
        returnedMap[newType] = newTypeIsRead;
      } else {
        if (!newTypeIsRead && returnedMap[newType] == true) {
          returnedMap[newType] = newTypeIsRead;
        }
      }
    }
    if (returnedMap.isEmpty) {
      returnedMap["عمومی"] = true;
    }
    return returnedMap;
  }

  List<AppNotificationSubsribe> _allNotificationSubscribes = [];
  List<AppNotificationSubsribe> get allNotificationSubscribes =>
      _allNotificationSubscribes;
  List<AppUserNotification> _allNotifications = [];
  List<AppUserNotification> get allNotifications => _allNotifications;
  List<AppUserNotification> get unReadNotifications =>
      _allNotifications.where((eleme) => eleme.isRead == false).toList();

  List<String> _usernotificationdeactive = [];
  List<String> get usernotificationdeactive => _usernotificationdeactive;
  List<String> notificationChoices = [
    'عمومی',
    'اطلاع رسانی',
    'فروشندگان',
    'کاربر',
    'تبلیغات',
  ];
}
