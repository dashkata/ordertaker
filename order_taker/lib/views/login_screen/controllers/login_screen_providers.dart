import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/repository_providers.dart';
import 'login_state_controller.dart';

final loginEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final loginPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final loginStateProvider = StateNotifierProvider<LoginStateNotifier, void>(
  (ref) => LoginStateNotifier(
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
