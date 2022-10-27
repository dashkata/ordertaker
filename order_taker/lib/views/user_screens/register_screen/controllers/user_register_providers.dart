import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/user_screens/register_screen/controllers/user_register_controller.dart';

import '../../../../providers/repository_providers.dart';

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
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
  ),
);
