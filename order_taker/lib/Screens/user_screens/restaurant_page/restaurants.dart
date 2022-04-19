import 'package:flutter/material.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurant_widget.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView(
              children: const [
                // Card(),
                RestaurantCard(
                  resTitle: "Pizza Don Vito",
                  resDesc: "Restaurant Desc",
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
