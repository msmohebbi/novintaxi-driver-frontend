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
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CupertinoAlertDialog(
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'شما در حال تایید و شروع سفر جدید هستید',
              style: TextStyle(
                height: 2,
                fontSize: 13,
                fontFamily: 'IRANYekan',
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: kToolbarHeight * 0.1),
            Text(
              'آیا مطمئن هستید؟',
              style: TextStyle(
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
            onPressed: () async {
              await Provider.of<DriverTransportData>(context, listen: false)
                  .confirmTransport(widget.cTransport);

              if (mounted) {
                Provider.of<SettingData>(context, listen: false).setbnbIndex(1);
              }

              if (mounted) {
                Navigator.of(context).pop();
              }
            },
            icon: Provider.of<DriverTransportData>(context).isConfirmingId ==
                    widget.cTransport.id
                ? const CupertinoActivityIndicator()
                : const Text(
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
