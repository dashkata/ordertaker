import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/repositories/auth_repository.dart';
import 'package:order_taker/views/resources/route_manager.dart';

class LoginStateNotifier extends StateNotifier<void> {
  LoginStateNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  void navigateToRegister() {
    navigatorKey.currentState!.popAndPushNamed(Routes.register);
  }

  void login(String email, String password, BuildContext context) async {
    GFToast.showToast(
      await _authRepository.signIn(
        email: email,
        password: password,
      ),
      context,
      toastDuration: 5,
    );
    navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }
}
