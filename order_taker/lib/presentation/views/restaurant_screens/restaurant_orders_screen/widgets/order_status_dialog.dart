part of '../restaurant_order.dart';

class _OrderStatusTitle extends StatelessWidget {
  const _OrderStatusTitle({required this.currentStatus, Key? key})
      : super(key: key);
  final String currentStatus;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: Text(
              'Set order status',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Center(
            child: Text(
              'Current status: $currentStatus',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      );
}

class _OrderStatusContent extends ConsumerWidget {
  const _OrderStatusContent({
    required this.orderId,
    required this.tableId,
    Key? key,
  }) : super(key: key);
  final int orderId;
  final int tableId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return ref.watch(restaurantTitleProvider).when(
          data: (title) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                buttonText: text.in_progress,
                buttonFunc: () async => await ref
                    .read(restaurantOrderViewModelProvider.notifier)
                    .updateOrderStatus(
                      orderId: orderId,
                      tableId: tableId,
                      orderStatus: OrderStatus.progress,
                      title: title,
                    ),
              ),
              CustomButton(
                buttonText: text.completed,
                buttonFunc: () async => await ref
                    .read(restaurantOrderViewModelProvider.notifier)
                    .updateOrderStatus(
                      orderId: orderId,
                      tableId: tableId,
                      orderStatus: OrderStatus.completed,
                      title: title,
                    ),
              ),
            ],
          ),
          error: (e, s) => Text(
            e.toString(),
          ),
          loading: CustomProgressIndicator.new,
        );
  }
}
