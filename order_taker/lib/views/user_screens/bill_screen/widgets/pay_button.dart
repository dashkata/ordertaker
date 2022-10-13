// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../../project_widgets.dart';
part of '../bill.dart';
class PayButton extends StatelessWidget {
  const PayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: NormalButtons(
        buttonText: text.pay,
        buttonFunc: () {},
      ),
    );
  }
}
