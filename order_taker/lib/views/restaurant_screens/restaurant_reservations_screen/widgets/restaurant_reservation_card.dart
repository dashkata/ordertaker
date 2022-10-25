part of '../restaurant_reservations.dart';

class _RestaurantReservationCard extends ConsumerWidget {
  const _RestaurantReservationCard({
    required this.reservation,
    required this.args,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;
  final RestaurantOrderArguments args;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: PaddingManager.p11,
      child: GestureDetector(
        onTap: () async => await ref
                .read(firestoreRepositoryProvider)
                .checkForCurrentReservation(args.restaurantTitle, args.id)
            ? await showDialog(
                context: context,
                builder: (_) => CardAlertDialog(
                  reservation: reservation,
                  args: args,
                ),
              )
            : null,
        child: Card(
          color: complementaryColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: PaddingManager.p4,
            child: Column(
              children: [
                Text(
                  '${text.client_name} - ${reservation.name}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  '${text.reservation_date} - ${reservation.date}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '${text.number_of_people} - ${reservation.numberOfPeople.toString()}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
