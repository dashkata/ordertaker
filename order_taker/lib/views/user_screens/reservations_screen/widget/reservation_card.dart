part of '../reservations.dart';

class _ReservationCard extends ConsumerWidget {
  const _ReservationCard({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;

    return Padding(
      padding: PaddingManager.p11,
      child: GestureDetector(
        onTap: () => ref
            .read(userReservationProvider.notifier)
            .navigateToMenu(reservation),
        child: Card(
          color: complementaryColor,
          elevation: 10,
          shape: Styles.buildRoundedBorder(40),
          child: Row(
            children: [
              // Padding(
              //   padding: PaddingManager.p5,
              //   child: Consumer(
              //     builder: (context, ref, child) {
              //       final AsyncValue restaurantPic = ref.watch(
              //         restaurantPictureProvider(reservation.restaurant),
              //       );
              //       return restaurantPic.when(
              //         data: (imageUrl) => CachedNetworkImage(
              //           imageUrl: restaurantPic.value,
              //           imageBuilder: (context, url) => CircleAvatar(
              //             backgroundImage: url,
              //             radius: 40,
              //           ),
              //         ),
              //         error: (e, s) => Text(
              //           e.toString(),
              //         ),
              //         loading: () => const LoadingIndicator(),
              //       );
              //     },
              //   ),
              // ),
              _TitleColumn(
                reservation: reservation,
                text: text,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: IconButton(
                  onPressed: () => ref
                      .watch(userReservationProvider.notifier)
                      .deleteReservation(
                        reservation,
                        context,
                      ),
                  icon: const Icon(
                    Icons.cancel,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
