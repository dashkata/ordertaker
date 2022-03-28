import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/customwidgets.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomWidgets.returnBackground(),
          SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    InkWell(
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'lib/Assets/PizzaDonVito.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: const Text("Pizza Don Vito")),
                          ),
                          semanticContainer: true,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          margin: const EdgeInsets.all(20),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
