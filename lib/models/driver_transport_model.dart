import '../models/transport_model.dart';

class AppDriverTransport {
  AppDriverTransport({
    required this.id,
    required this.transport,
    required this.driver,
    required this.dateConfirmed,
    required this.dateArrived,
    required this.dateStarted,
    required this.dateEnded,
    required this.dateCanceled,
    required this.isCanceled,
  });
  int id;
  AppTransport transport;
  int driver;
  bool dateConfirmed;
  bool dateArrived;
  bool dateStarted;
  int dateEnded;
  String? dateCanceled;
  String isCanceled;

  AppDriverTransport.fromMap(Map<String, dynamic> newOrder)
      : id = newOrder["id"],
        transport = newOrder["transport"],
        driver = newOrder["driver"],
        dateConfirmed = newOrder["date_confirmed"],
        dateArrived = newOrder["date_arrived"],
        dateStarted = newOrder["date_started"],
        dateEnded = newOrder["date_ended"],
        dateCanceled = newOrder["date_canceled"],
        isCanceled = newOrder["is_canceled"];
}
