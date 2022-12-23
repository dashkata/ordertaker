part of '../reservations.dart';

class _TitleColumn extends StatelessWidget {
  const _TitleColumn({
    required this.reservation,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Reservation reservation;
  final AppLocalizations text;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reservation.restaurant,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            reservation.date,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            '${reservation.numberOfPeople.toString()} ${text.people}',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            '${text.status}: ${reservation.approved == null ? text.waiting : reservation.approved! ? text.approved : 'not approved'}',
            style: Theme.of(context).textTheme.headline6,
          ),
          if (reservation.table != null && reservation.table != 0)
            Text(
              'table: ${reservation.table}',
              style: Theme.of(context).textTheme.headline6,
            )
        ],
      );
}
