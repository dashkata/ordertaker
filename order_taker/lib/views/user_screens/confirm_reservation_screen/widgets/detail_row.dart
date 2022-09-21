import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Themes/themes.dart';
import '../../../../providers/confirm_reservation_providers.dart';

class DetailRow extends ConsumerWidget {
  const DetailRow({
    required this.reservationInfo,
    required this.text,
    Key? key,

  }) : super(key: key);

  final Map reservationInfo;
  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.calendar_month,
            size: 15,
            color: accentColor,
          ),
          Text(
            ref.watch(confirmDateProvider),
            style: Theme.of(context).textTheme.headline1,
          ),
          const Icon(
            Icons.watch_later_outlined,
            size: 15,
            color: accentColor,
          ),
          Text(
            ref.watch(confirmTimeProvider),
            style: Theme.of(context).textTheme.headline1,
          ),
          const Icon(
            Icons.person,
            size: 15,
            color: accentColor,
          ),
          Text(
            "${reservationInfo["numberOfPeople"]} ${text.people}",
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      );
}
