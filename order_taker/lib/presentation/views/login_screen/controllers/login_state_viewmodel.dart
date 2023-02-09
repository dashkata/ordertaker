import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';

import '../../resources/route_manager.dart';

class LoginViewModel extends StateNotifier<void> {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  void navigateToRegister() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.register);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    await _authRepository.signIn(
      email: email,
      password: password,
    );
  }
}
