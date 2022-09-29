import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/controller_providers.dart';
import '../../../../themes/themes.dart';

class BackArrowFAB extends ConsumerWidget {
  const BackArrowFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => FloatingActionButton(
    onPressed: () => ref
        .read(restaurantRegisterProvider.notifier)
        .navigateToRegister(),
    backgroundColor: complementaryColor,
    child: const Icon(
      Icons.arrow_back,
      color: accentColor,
    ),
  );
}