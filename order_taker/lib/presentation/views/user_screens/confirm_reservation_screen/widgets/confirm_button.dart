part of '../confirm_reservation.dart';

class _ConfirmButton extends ConsumerWidget {
  const _ConfirmButton({
    required this.text,
    required this.reservationInfo,
    required this.name,
    Key? key,
  }) : super(key: key);

  final AppLocalizations text;
  final ConfirmReservationArguments reservationInfo;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
        child: CustomButton(
          buttonText: text.confirm_reservation,
          buttonFunc: () => ref
              .read(userConfirmReservationViewModelProvider.notifier)
              .addReservation(
                reservation: Reservation(
                  name: name,
                  restaurant: reservationInfo.restaurant.title,
                  date: '${ref.read(confirmDateProvider)} '
                      '- ${ref.read(confirmTimeProvider)}',
                  numberOfPeople: reservationInfo.numberOfPeople,
                  userId:
                      ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                  currentReservation: false,
                  preferredLocation: reservationInfo.preferredLocation,
                ),
              ),
        ),
      );
}
