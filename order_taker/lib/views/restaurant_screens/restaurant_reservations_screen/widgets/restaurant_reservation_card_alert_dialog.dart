part of '../restaurant_reservations.dart';

class CardAlertDialog extends ConsumerWidget {
  const CardAlertDialog({
    required this.reservation,
    required this.args,
    Key? key,
  }) : super(key: key);

  final Reservation reservation;
  final RestaurantOrderArguments args;

  @override
  Widget build(BuildContext context, WidgetRef ref) => CustomAlertDialog(
        title: Text(
          'Are you sure you want to set this as current reservation?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              buttonFunc: () => navigatorKey.currentState!.pop(),
              buttonText: 'Cancel',
            ),
            CustomButton(
              buttonFunc: () {
                ref
                    .read(
                      restaurantReservationsControllerProvider.notifier,
                    )
                    .setCurrentReservation(
                      reservation,
                      args,
                    );
                navigatorKey.currentState!.pop();
              },
              buttonText: 'Confirm',
            ),
          ],
        ),
      );
}
