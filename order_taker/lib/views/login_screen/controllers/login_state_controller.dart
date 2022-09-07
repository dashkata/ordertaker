import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
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

  Future<void> login(String email, String password, BuildContext context) async {
    GFToast.showToast(
      await _authRepository.signIn(
        email: email,
        password: password,
      ),
      context,
      toastDuration: 5,
    );
    await navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }
}