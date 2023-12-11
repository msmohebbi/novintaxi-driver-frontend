import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/transport_od_model.dart';
import 'package:intl/intl.dart' as intl;

class AppTransport {
  AppTransport({
    required this.id,
    required this.back,
    required this.type,
    required this.price,
    required this.commision,
    required this.time,
    required this.meter,
    required this.adult,
    required this.child,
    required this.moreTime,
    required this.morePrice,
    required this.vehicle,
    required this.dateSchedule,
    required this.detail,
    required this.geometery,
    required this.date,
    required this.followingCode,
    required this.passengerName,
    required this.passengerPhone,
    required this.status,
    required this.animal,
    required this.extraLoad,
    required this.invoice,
    required this.isCanceled,
  });
  int id;
  bool back;
  String type;
  String get typeFa {
    if (type == 'scheduled') {
      return 'برنامه ریزی شده';
    } else {
      return 'فوری';
    }
  }

  int price;
  int commision;
  double time;
  double meter;
  String get meterKMString {
    var rialFormat = intl.NumberFormat.currency(
      // customPattern: "###",
      locale: "fa_IR",
      decimalDigits: 0,
      symbol: "",
      customPattern: kIsWeb ? "####################" : null,
    );
    return rialFormat.format(meter ~/ 1000);
  }

  int adult;
  int child;
  int moreTime;
  int morePrice;
  int vehicle;
  int date;
  String status;
  String followingCode;
  String? passengerName;
  String? passengerPhone;
  bool animal;
  bool extraLoad;
  bool invoice;
  bool isCanceled;
  String? detail;
  String? geometery;
  int? dateSchedule;
  List<AppTransportOD>? ods;

  String? get dateScheduleDateString {
    if (dateSchedule != null) {
      Jalali? jalali = Jalali.fromDateTime(
          DateTime.fromMillisecondsSinceEpoch(dateSchedule!));
      return jalali.formatFullDate();
    }
    return null;
  }

  TimeOfDay? get dateScheduleTimeString {
    if (dateSchedule != null) {
      TimeOfDay? time = TimeOfDay.fromDateTime(
          DateTime.fromMillisecondsSinceEpoch(dateSchedule!));
      return time;
    }
    return null;
  }

  Map<String, dynamic> toMapwithOD(List<AppTransportOD> ods) {
    var mapedObj = {
      "vehicle": vehicle,
      "transport_ods": ods.map((e) => e.toMap())
    };
    return mapedObj;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "back": back,
      "type": type,
      "price": price,
      "commision": commision,
      "time": time,
      "meter": meter,
      "adult": adult,
      "child": child,
      "more_time": moreTime,
      "more_price": morePrice,
      "vehicle": vehicle,
      "date_schedule": dateSchedule,
      "detail": detail,
      "date": date,
      "status": status,
      "animal": animal,
      "extra_load": extraLoad,
      "invoice": invoice,
      "is_canceled": isCanceled,
      "following_code": followingCode,
      "passenger_name": passengerName,
      "passenger_phone": passengerPhone,
    };
  }

  AppTransport.fromMap(Map<String, dynamic> newOrder)
      : id = newOrder["id"],
        back = newOrder["back"],
        type = newOrder["type"],
        price = newOrder["price"],
        // TODO
        commision = newOrder["commision"] ?? 0,
        time = newOrder["time"],
        meter = newOrder["meter"],
        adult = newOrder["adult"],
        child = newOrder["child"],
        moreTime = newOrder["more_time"],
        morePrice = newOrder["more_price"],
        vehicle = newOrder["vehicle"],
        dateSchedule = newOrder["date_schedule"],
        detail = newOrder["detail"],
        geometery = newOrder["geometery"],
        date = newOrder["date"],
        status = newOrder["status"],
        animal = newOrder["animal"],
        extraLoad = newOrder["extra_load"],
        invoice = newOrder["invoice"],
        isCanceled = newOrder["is_canceled"],
        followingCode = newOrder["following_code"],
        passengerName = newOrder["passenger_name"],
        passengerPhone = newOrder["passenger_phone"] {
    ods = newOrder["transport_ods"] != null
        ? (newOrder["transport_ods"] as List)
            .map((e) => AppTransportOD.fromMapWithTransport(e, this))
            .toList()
        : null;
  }
}
