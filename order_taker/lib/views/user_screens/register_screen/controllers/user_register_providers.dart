import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import 'user_register_controller.dart';

final registerEmailControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerPasswordControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerFirstNameControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerLastNameControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerPhoneNumberControllerProvider = StateProvider.autoDispose(
  (ref) => '',
);
final userRegisterProvider =
    StateNotifierProvider<UserRegisterScreenNotifier, void>(
  (ref) => UserRegisterScreenNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
  ),
);
