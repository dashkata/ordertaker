import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/padding_manager.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Row(
      children: [
        Padding(
          padding: PaddingManager.p13,
          child: Text(
            text.welcome,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
