import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/order_model.dart';
import '../../../providers/restaurant_orders_provider.dart';
import '../../project_widgets.dart';
import 'widgets/order_container.dart';

class RestaurantOrders extends StatelessWidget {
  const RestaurantOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
              child: Consumer(
                builder: (context, ref, child) {
                  final AsyncValue<List<Order>> orders =
                      ref.watch(fetchRestaurantOrdersProvider);

                  return orders.when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20,
                        ),
                        child: OrderContainer(
                          menuItems: data[index].menuItems,
                          orderId: index + 1,
                        ),
                      ),
                    ),
                    error: (e, s) => Text(e.toString()),
                    loading: () => const LoadingIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
