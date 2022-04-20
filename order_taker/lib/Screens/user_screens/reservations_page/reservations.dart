import 'package:flutter/material.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';
import 'reservation_widgets.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appBarColor),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView(
              children: const [
                ReservationCard(
                  titleText: "Pizza Don Vito",
                  date: "Friday, April 8, 15:30 PM",
                  imagePath: "PizzaDonVito.jpg",
                ),
                ReservationCard(
                  titleText: "Pizza Don Vito",
                  date: "Friday, April 8, 15:30 PM",
                  imagePath: "PizzaDonVito.jpg",
                ),
                ReservationCard(
                  titleText: "Pizza Don Vito",
                  date: "Friday, April 8, 15:30 PM",
                  imagePath: "PizzaDonVito.jpg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}