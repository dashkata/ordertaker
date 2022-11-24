part of '../bill.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context) => Material(
        elevation: 5,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            orders.length,
                            (int ordersIndex) => Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: List.generate(
                                  orders[ordersIndex].menuItems.keys.length,
                                  (menuIndex) => Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    child: Text(
                                      '${orders[ordersIndex].menuItems.keys.elementAt(menuIndex).itemTitle}'
                                      ' - ${orders[ordersIndex].menuItems.keys.elementAt(menuIndex).itemPrice} '
                                      'x${orders[ordersIndex].menuItems[orders[ordersIndex].menuItems.keys.elementAt(menuIndex)]}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (ref.read(totalPriceProvider(orders)) != 0.0)
                          Text(
                            'Total price: ${ref.watch(totalPriceProvider(orders)).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headline1,
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                error: (e, s) => ErrorAlertDialog(
                  errorMessage: e.toString(),
                ),
                loading: () => const CustomProgressIndicator(),
              );
            },
          ),
        ),
      );
}
