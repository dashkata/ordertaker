// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../../project_widgets.dart';
part of '../bill.dart';

class PayButton extends ConsumerWidget {
  const PayButton({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: NormalButtons(
        buttonText: text.pay,
        buttonFunc: () =>
            ref.read(billScreenProvider.notifier).pay(reservation),
      ),
    );
  }
}
