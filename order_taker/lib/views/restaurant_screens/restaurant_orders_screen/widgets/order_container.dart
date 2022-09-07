import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Themes/themes.dart';
import '../../../../models/menu_item_model.dart';
import '../../../../providers/controller_providers.dart';

class OrderContainer extends ConsumerWidget {
  const OrderContainer({
    required this.menuItems,
    required this.orderId,
    Key? key,
  }) : super(key: key);
  final List<OrderItem> menuItems;
  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        decoration: contentContainerDecoration,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderTitle(
              orderNumber: orderId,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) =>
                  RestaurantMenuItem(
                item: menuItems[index].itemTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5.0),
              child: OrderButton(
                buttonText: 'See additional messages',
                onPressed: () => ref
                    .read(restaurantOrderNotifierProvider.notifier)
                    .seeAdditionalMessages(context, ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: OrderButton(
                buttonText: 'Set status',
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
}

class OrderTitle extends StatelessWidget {
  const OrderTitle({
    required this.orderNumber,
    Key? key,
  }) : super(key: key);
  final int orderNumber;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Text(
            'Order $orderNumber',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      );
}

class OrderButton extends StatelessWidget {
  const OrderButton({
    required this.onPressed,
    required this.buttonText,
    Key? key,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            elevation: 10,
            shape: const StadiumBorder(),
          ),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      );
}

class RestaurantMenuItem extends StatelessWidget {
  const RestaurantMenuItem({
    required this.item,
    Key? key,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 30),
        child: Text(
          '- $item',
          style: Theme.of(context).textTheme.headline3,
        ),
      );
}
