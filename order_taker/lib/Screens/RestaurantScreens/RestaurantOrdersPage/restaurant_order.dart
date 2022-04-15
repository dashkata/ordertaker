import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Screens/RestaurantScreens/RestaurantOrdersPage/restaurant_order_widgets.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

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
                        MenuItem(
                          item: "Пържени картофки х2",
                        ),
                        MenuItem(item: "Пица Пеперони малка"),
                        Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 5.0),
                            child: OrderButton(
                                buttonText: "See additional messages")),
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
