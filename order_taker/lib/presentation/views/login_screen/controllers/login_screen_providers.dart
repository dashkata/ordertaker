import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'login_state_viewmodel.dart';

final loginEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final loginPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, void>(
  (ref) => LoginViewModel(
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
