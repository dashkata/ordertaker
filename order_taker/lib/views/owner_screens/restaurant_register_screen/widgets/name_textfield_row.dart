import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/controller_providers.dart';
import '../../../../providers/restaurant_register_provider.dart';
import '../../../project_widgets.dart';

class NameTextFieldRow extends ConsumerWidget {
  const NameTextFieldRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: DoubleTextField(
            func: (value) {
              ref
                  .read(
                restaurantRegisterProvider.notifier,
              )
                  .updateText(
                restaurantFirstNameProvider,
                value,
              );
            },
            hintText: 'First Name',
            icon: Icons.person,
            obscure: false,
            inputType: TextInputType.name,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: DoubleTextField(
            func: (value) => ref
                .read(
              restaurantRegisterProvider.notifier,
            )
                .updateText(
              restaurantLastNameProvider,
              value,
            ),
            hintText: 'Last Name',
            icon: Icons.person,
            obscure: false,
            inputType: TextInputType.name,
          ),
        ),
      ),
    ],
  );
}