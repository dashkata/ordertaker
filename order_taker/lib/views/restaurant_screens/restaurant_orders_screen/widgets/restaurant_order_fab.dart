part of '../restaurant_order.dart';

class _RestaurantOrderFABRow extends ConsumerWidget {
  const _RestaurantOrderFABRow({
    required this.restaurantOrderArguments,
    Key? key,
  }) : super(key: key);

  final RestaurantOrderArguments restaurantOrderArguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RestaurantOrderFAB(
            icon: Icons.table_bar,
            onPressed: () => ref
                .read(restaurantOrderNotifierProvider.notifier)
                .navigateToTables(),
            heroTag: 'orderFab1',
          ),
          RestaurantOrderFAB(
            onPressed: () => ref
                .read(restaurantOrderNotifierProvider.notifier)
                .navigateToReservations(restaurantOrderArguments),
            icon: Icons.note_alt_outlined,
            heroTag: 'orderFab2',
          )
        ],
      );
}

class RestaurantOrderFAB extends StatelessWidget {
  const RestaurantOrderFAB({
    required this.onPressed,
    required this.icon,
    required this.heroTag,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final IconData icon;

  final String heroTag;

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: onPressed,
        heroTag: heroTag,
        child: Icon(
          icon,
          color: mainColor,
          size: 35,
        ),
      );
}
