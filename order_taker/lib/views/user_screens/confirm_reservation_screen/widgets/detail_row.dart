part of '../confirm_reservation.dart';

class _DetailRow extends ConsumerWidget {
  const _DetailRow({
    required this.reservationInfo,
    required this.text,
    Key? key,
  }) : super(key: key);

  final ConfirmReservationArguments reservationInfo;
  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.calendar_month,
            size: 15,
            color: accentBlackColor,
          ),
          Text(
            ref.watch(confirmDateProvider),
            style: Theme.of(context).textTheme.headline1,
          ),
          const Icon(
            Icons.watch_later_outlined,
            size: 15,
            color: accentBlackColor,
          ),
          Text(
            ref.watch(confirmTimeProvider),
            style: Theme.of(context).textTheme.headline1,
          ),
          const Icon(
            Icons.person,
            size: 15,
            color: accentBlackColor,
          ),
          Text(
            '${reservationInfo.numberOfPeople} ${text.people}',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      );
}
