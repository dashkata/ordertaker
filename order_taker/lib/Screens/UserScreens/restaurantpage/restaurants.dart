import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurant_widget.dart';
import 'package:order_taker/Screens/customwidgets.dart';

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
        backgroundColor: Colors.amber[300],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
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
                height: 250, // card height
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
