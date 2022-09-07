import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../themes/themes.dart';
import '../../../resources/style_manager.dart';

class ReviewTextField extends StatelessWidget {
  const ReviewTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return TextField(
      decoration: InputDecoration(
        enabledBorder: Styles.buildOutlineBorder(
          complementaryColor,
          30,
        ),
        border: Styles.buildOutlineBorder(
          complementaryColor,
          30,
        ),
        hintText: text.write_a_review,
        filled: true,
        fillColor: mainColor,
        hintStyle: Theme.of(context).textTheme.headline1,
      ),
      autocorrect: false,
      maxLength: 200,
      maxLines: 4,
    );
  }
}