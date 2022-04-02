import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:getwidget/getwidget.dart';

import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurant_widget.dart';
import 'package:order_taker/Screens/project_widgets.dart';
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
      drawer: const CustomDrawer(),
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
                      child: RestaurantCards(
                        imagePath: "PizzaDonVito.jpg",
                        restaurantName: "Pizza Don Vito",
                        restaurantInfo: "A nice pizza restaurant",
                      ),
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
