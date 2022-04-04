import 'package:flutter/material.dart';
import 'package:order_taker/Screens/project_widgets.dart';

class ConfirmReservation extends StatefulWidget {
  const ConfirmReservation({Key? key}) : super(key: key);

  @override
  State<ConfirmReservation> createState() => _ConfirmReservationState();
}

class _ConfirmReservationState extends State<ConfirmReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Text("Confirm reservation"),
          ),
        ],
      ),
    );
  }
}
