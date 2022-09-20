import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Themes/themes.dart';
import '../../../../models/order_model.dart';
import '../../../../models/reservation_model.dart';
import '../../../../providers/bill_screen_providers.dart';
import '../../../project_widgets.dart';
import '../../../resources/style_manager.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context) => Material(
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
              final AsyncValue<List<Order>> futureOrders =
                  ref.watch(fetchOrdersProvider(reservation));
              return futureOrders.when(
                data: (orders) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int ordersIndex) =>
                        Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: List.generate(
                          orders[ordersIndex].menuItems.length,
                          (menuIndex) => Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              '${orders[ordersIndex].menuItems[menuIndex].itemTitle} '
                              '- ${orders[ordersIndex].menuItems[menuIndex].itemPrice}',
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
