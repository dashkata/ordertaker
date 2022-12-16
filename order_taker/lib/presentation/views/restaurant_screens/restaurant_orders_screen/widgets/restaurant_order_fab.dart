part of '../restaurant_order.dart';

class _RestaurantOrderFABRow extends ConsumerWidget {
  const _RestaurantOrderFABRow({
    required this.restaurantOrderArguments,
    Key? key,
  }) : super(key: key);

  final RestaurantOrderArguments restaurantOrderArguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) => RestaurantOrderFAB(
        onPressed: () => ref
            .read(restaurantOrderControllerProvider.notifier)
            .navigateToReservations(restaurantOrderArguments),
        icon: Icons.note_alt_outlined,
        heroTag: 'orderFab2',
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
        backgroundColor: accentBlackColor,
        onPressed: onPressed,
        heroTag: heroTag,
        child: Icon(
          icon,
          color: mainColor,
          size: 35,
        ),
      );
}
