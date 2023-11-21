import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transport_data.dart';
import '../widgets/transport_summary_modal.dart';
import '../widgets/transport_vehicle_modal.dart';
import '../widgets/transport_client_modal.dart';
import '../widgets/transport_options_modal.dart';

class GeneralMapModal extends StatefulWidget {
  const GeneralMapModal({super.key});

  @override
  State<GeneralMapModal> createState() => _GeneralMapModalState();
}

class _GeneralMapModalState extends State<GeneralMapModal> {
  @override
  void dispose() {
    Provider.of<TransportData>(context, listen: false).setModalIndex(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var index = Provider.of<TransportData>(context).modalIndex;
    var modalsList = [
      const TransportVehicleModal(),
      const TransportOptionModal(),
      const TransportClientModal(),
      const TransportSummaryModal(),
    ];
    return modalsList[index];
  }
}
