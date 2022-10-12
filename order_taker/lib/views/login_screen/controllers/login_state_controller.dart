import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/auth_repository.dart';
import '../../resources/route_manager.dart';

class LoginStateNotifier extends StateNotifier<void> {
  LoginStateNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  void navigateToRegister() {
    navigatorKey.currentState!.popAndPushNamed(Routes.register);
  }

  Future<String> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    final String message = await _authRepository.signIn(
      email: email,
      password: password,
    );
    await navigatorKey.currentState!.popAndPushNamed(Routes.auth);
    return message;
  }
}
