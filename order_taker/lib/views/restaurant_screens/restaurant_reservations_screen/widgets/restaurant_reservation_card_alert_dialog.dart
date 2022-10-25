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
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return CustomAlertDialog(
      title: Text(
        text.current_reservation,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            buttonFunc: () => navigatorKey.currentState!.pop(),
            buttonText: text.cancel,
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
            buttonText: text.submit,
          ),
        ],
      ),
    );
  }
}
