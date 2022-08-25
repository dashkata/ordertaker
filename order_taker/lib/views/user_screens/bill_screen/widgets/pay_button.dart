import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../Themes/themes.dart';
import '../../../resources/style_manager.dart';

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
        textStyle: Styles.buildTextStyle(
          accentColor,
          15,
          FontWeight.bold,
          FontStyle.normal,
        ),
        elevation: 10,
      ),
    );
  }
}
