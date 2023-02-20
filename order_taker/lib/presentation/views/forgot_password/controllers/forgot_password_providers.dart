import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';
import 'package:order_taker/presentation/views/forgot_password/controllers/forgot_password_viewmodel.dart';

final emailControllerProvider = StateProvider<String>((ref) => '');
final forgotPasswordViewModelProvider = StateNotifierProvider(
  (ref) => ForgotPasswordViewModel(
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
