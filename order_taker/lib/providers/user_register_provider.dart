import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final passwordProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final firstNameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final lastNameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final numberProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);
