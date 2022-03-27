import 'package:flutter/material.dart';
import 'package:order_taker/Screens/customwidgets.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomWidgets.returnBackground(),
        ],
      ),
    );
  }
}
