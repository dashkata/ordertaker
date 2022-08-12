import 'package:flutter/material.dart';
import 'package:order_taker/themes/themes.dart';

import '../../project_widgets.dart';
import 'restaurant_order_widgets.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Container(
                    decoration: contentContainerDecoration,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        OrderTitle(
                          orderNumber: 1,
                        ),
                        RestaurantMenuItem(
                          item: "Пържени картофки х2",
                        ),
                        RestaurantMenuItem(item: "Пица Пеперони малка"),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5.0),
                          child: OrderButton(
                              buttonText: "See additional messages"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: OrderButton(
                            buttonText: "Set status",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
