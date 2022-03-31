import 'package:flutter/material.dart';
import 'package:order_taker/Screens/project_widgets.dart';

class CurrentReservation extends StatelessWidget {
  const CurrentReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BackgroundWidget(),
        SafeArea(child: Text("current reservation")),
      ]),
    );
  }
}
