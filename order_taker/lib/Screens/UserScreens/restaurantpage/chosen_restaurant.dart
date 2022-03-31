import 'package:flutter/material.dart';
import 'package:order_taker/Screens/project_widgets.dart';

class ChosenRestaurant extends StatelessWidget {
  const ChosenRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Text("Chosen restaurant"),
          ),
        ],
      ),
    );
  }
}
