part of '../reservations.dart';

class _CancelReservationDialog extends ConsumerWidget {
  const _CancelReservationDialog({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return CustomAlertDialog(
      title: Center(
        child: Text(
          text.cancel_reservation_question,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            buttonText: text.cancel,
            buttonFunc: () => navigatorKey.currentState!.pop(),
          ),
          CustomButton(
            buttonText: text.confirm,
            buttonFunc: () async {
              await ref.read(reservationRepositoryProvider).deleteReservation(
                    ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                    reservation,
                  );
              navigatorKey.currentState!.pop();
            },
          ),
        ],
      ),
    );
  }
}
