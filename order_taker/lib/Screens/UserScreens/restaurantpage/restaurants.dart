import 'package:flutter/material.dart';

import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurant_widget.dart';
import 'package:order_taker/Screens/customwidgets.dart';
import 'package:order_taker/Themes/themes.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: appBarColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("The name of the user"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_pizza),
              title: const Text('Restaurants'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: const Text('Reservations'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: SizedBox(
                height: 240, // card height
                child: PageView.builder(
                  itemCount: 10,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: const RestaurantCards(
                          imagePath: "PizzaDonVito.jpg",
                          restaurantName: "Pizza Don Vito",
                          restaurantInfo: "A nice pizza restaurant"),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
