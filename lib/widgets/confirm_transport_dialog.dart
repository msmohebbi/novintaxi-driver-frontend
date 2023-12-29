import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novintaxidriver/models/transport_model.dart';
import 'package:novintaxidriver/providers/driver_transport_data.dart';
import 'package:novintaxidriver/providers/settings_data.dart';
import 'package:provider/provider.dart';

class ConfirmTransportDialog extends StatefulWidget {
  final AppTransport cTransport;

  const ConfirmTransportDialog({super.key, required this.cTransport});

  @override
  State<ConfirmTransportDialog> createState() => _ConfirmTransportDialogState();
}

class _ConfirmTransportDialogState extends State<ConfirmTransportDialog> {
  int seconds = 15;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (seconds == 0) {
            timer.cancel();
          } else {
            seconds--;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CupertinoAlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'شما در حال تایید و شروع سفر جدید هستید',
              style: TextStyle(
                height: 2,
                fontSize: 13,
                fontFamily: 'IRANYekan',
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.1),
            const Text(
              'آیا مطمئن هستید؟',
              style: TextStyle(
                height: 2,
                fontSize: 12,
                fontFamily: 'IRANYekan',
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.1),
            Text(
              '$seconds ثانیه صبر کنید',
              style: const TextStyle(
                height: 2,
                fontSize: 12,
                fontFamily: 'IRANYekan',
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: seconds == 0
                ? () async {
                    Provider.of<DriverTransportData>(context, listen: false)
                        .confirmTransport(widget.cTransport)
                        .then((value) {
                      Provider.of<SettingData>(context, listen: false)
                          .setbnbIndex(1);
                    });
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Text(
              'تایید سفر',
              style: TextStyle(
                color: Colors.teal,
                height: 2,
                fontSize: 13,
                fontFamily: 'IRANYekan',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Text(
              'بیخیال',
              style: TextStyle(
                height: 2,
                fontSize: 13,
                fontFamily: 'IRANYekan',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
