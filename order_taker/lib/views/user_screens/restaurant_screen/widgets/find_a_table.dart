import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/controller_providers.dart';
import '../../../project_widgets.dart';

class FindATableButton extends ConsumerWidget {
  const FindATableButton({
    Key? key,
    required this.resTitle,
  }) : super(key: key);

  final String resTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: NormalButtons(
        buttonText: 'Find a Table',
        buttonFunc: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDetailsDialog(context, resTitle, ref),
      ),
    );
  }
}
