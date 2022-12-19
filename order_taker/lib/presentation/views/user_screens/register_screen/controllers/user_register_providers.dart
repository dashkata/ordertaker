import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

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
final userRegisterControllerProvider =
    StateNotifierProvider<UserRegisterController, void>(
  (ref) => UserRegisterController(
    authRepository: ref.watch(authRepositoryProvider),
    userRepo: ref.watch(userRepositoryProvider),
  ),
);
