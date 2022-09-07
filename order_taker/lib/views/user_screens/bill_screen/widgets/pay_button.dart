import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:getwidget/getwidget.dart';

import '../../../../Themes/themes.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: GFButton(
        onPressed: () {},
        shape: GFButtonShape.pills,
        color: complementaryColor,
        text: text.pay,
        textStyle: Theme.of(context).textTheme.headline3,
        elevation: 10,
      ),
    );
  }
}
