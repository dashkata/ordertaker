import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';

import '../../resources/route_manager.dart';

class LoginViewModel extends StateNotifier<void> {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  Future<void> navigateToRegister() async =>
      await navigatorKey.currentState!.pushReplacementNamed(Routes.register);

  Future<void> navigateToForgotPassword() async =>
      await navigatorKey.currentState!.pushNamed(
        Routes.forgotPassword,
      );

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _authRepository.signIn(
      email: email,
      password: password,
    );
  }
}
