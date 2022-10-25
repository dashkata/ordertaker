part of '../restaurant_order.dart';

class _OrderContainer extends ConsumerWidget {
  const _OrderContainer({
    required this.order,
    required this.tableId,
    Key? key,
  }) : super(key: key);
  final Order order;
  final int tableId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Container(
      decoration: contentContainerDecoration,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (order.status == 'Completed')
                const Padding(
                  padding: EdgeInsets.only(top: 5, right: 5),
                  child: Icon(
                    Icons.check_circle,
                    size: 35,
                    color: complementaryColor2,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
          if (order.status != 'Completed')
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _OrderTitle(
                orderNumber: order.id + 1,
              ),
            )
          else
            _OrderTitle(
              orderNumber: order.id + 1,
            ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: order.menuItems.length,
            itemBuilder: (BuildContext context, int index) =>
                RestaurantMenuItem(
              item: order.menuItems.keys.elementAt(index).itemTitle,
              count: order.menuItems[order.menuItems.keys.elementAt(index)]!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5.0),
            child: CustomButton(
              buttonText: text.additional_messages,
              buttonFunc: () => ref
                  .read(restaurantOrderNotifierProvider.notifier)
                  .seeAdditionalMessages(
                    context,
                    order.additionalMessage,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CustomButton(
              buttonText: text.set_status,
              buttonFunc: () async => await ref
                  .read(restaurantOrderNotifierProvider.notifier)
                  .setStatus(
                    order.id,
                    order.status,
                    tableId,
                    context,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTitle extends StatelessWidget {
  const _OrderTitle({
    required this.orderNumber,
    Key? key,
  }) : super(key: key);
  final int orderNumber;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        '${text.order} $orderNumber',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class _OrderButton extends StatelessWidget {
  const _OrderButton({
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
    required this.count,
    Key? key,
  }) : super(key: key);

  final String item;
  final int count;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            '- $item x${count.toString()}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );
}
