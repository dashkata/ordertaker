import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:order_taker/providers/user_register_provider.dart';
import 'package:order_taker/views/project_widgets.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NameRow extends ConsumerWidget {
  const NameRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: PaddingManager.p14,
            child: DoubleTextField(
              func: (value) => ref
                  .read(firstNameProvider.notifier)
                  .update((state) => value),
              hintText: text.first_name,
              icon: Icons.person,
              obscure: false,
              inputType: TextInputType.name,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: PaddingManager.p15,
            child: DoubleTextField(
              func: (value) => ref
                  .read(lastNameProvider.notifier)
                  .update((state) => value),
              hintText: text.last_name,
              icon: Icons.person,
              obscure: false,
              inputType: TextInputType.name,
            ),
          ),
        ),
      ],
    );
  }
}