import '../models/transport_model.dart';

class AppDriverTransport {
  AppDriverTransport({
    required this.id,
    required this.transport,
    required this.driver,
    required this.dateConfirmed,
    required this.datePaid,
    required this.dateArrived,
    required this.dateStarted,
    required this.dateEnded,
    required this.dateCanceled,
    required this.isCanceled,
  });
  int id;
  AppTransport transport;
  int driver;
  int dateConfirmed;
  int? datePaid;
  int? dateArrived;
  int? dateStarted;
  int? dateEnded;
  int? dateCanceled;
  bool isCanceled;
  int get statusId {
    if (isCanceled) {
      return 5;
    } else if (dateEnded != null) {
      return 4;
    } else if (dateStarted != null) {
      return 3;
    } else if (dateArrived != null) {
      return 2;
    } else if (datePaid != null) {
      return 1;
    } else {
      return 0;
    }
  }

  String get status {
    var statusList = [
      'در انتظار تایید و پرداخت کاربر',
      'در انتظار رسیدن به مبدا',
      'منتظر مسافر',
      'سفر شروع شده',
      'به اتمام رسیده',
      'لغو شده',
    ];
    return statusList[statusId];
  }

  String? get actionButtonString {
    var statusList = [
      null,
      'به مبدا رسیدم',
      'شروع سفر',
      'پایان سفر',
      null,
      null,
    ];
    return statusList[statusId];
  }

  String? get navigatorButtonString {
    var statusList = [
      null,
      'مسیریابی تا مبدا',
      'مسیریابی سفر',
      'مسیریابی سفر',
      null,
      null,
    ];
    return statusList[statusId];
  }

  AppDriverTransport.fromMap(Map<String, dynamic> newOrder)
      : id = newOrder["id"],
        transport = AppTransport.fromMap(newOrder["transport"]),
        driver = newOrder["driver"],
        dateConfirmed = newOrder["date_confirmed"],
        datePaid = newOrder["date_paid"],
        dateArrived = newOrder["date_arrived"],
        dateStarted = newOrder["date_started"],
        dateEnded = newOrder["date_ended"],
        dateCanceled = newOrder["date_canceled"],
        isCanceled = newOrder["is_canceled"];
}
