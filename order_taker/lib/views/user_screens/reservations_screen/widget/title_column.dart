import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:order_taker/models/reservation_model.dart';

class TitleColumn extends StatelessWidget {
  const TitleColumn({
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
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            '${reservation.numberOfPeople.toString()} ${text.people}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      );
}
