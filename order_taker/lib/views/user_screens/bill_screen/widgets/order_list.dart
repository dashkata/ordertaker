import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/models/order_model.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/bill_screen_providers.dart';
import 'package:order_taker/views/project_widgets.dart';
import 'package:order_taker/views/resources/style_manager.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
    required this.reservation,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: Styles.buildBorderRadius(40),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: Styles.buildBoxDecoration(
          40,
          complementaryColor,
        ),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            AsyncValue<List<Order>> futureOrders =
                ref.watch(fetchOrdersProvider(reservation));
            return futureOrders.when(
              data: (orders) => ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int ordersIndex) => Column(
                  children: List.generate(
                    orders[ordersIndex].menuItems.length,
                    (menuIndex) => Text(
                      orders[ordersIndex].menuItems[menuIndex].itemIngredients,
                    ),
                  ),
                ),
              ),
              error: (e, s) => Text(
                e.toString(),
              ),
              loading: () => const LoadingIndicator(),
            );
          },
        ),
      ),
    );
  }
}
