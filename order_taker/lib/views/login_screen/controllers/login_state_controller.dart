import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/auth_repository.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../project_widgets.dart';
import '../../resources/route_manager.dart';

class LoginController extends StateNotifier<void> {
  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  void navigateToRegister() {
    navigatorKey.currentState!.popAndPushNamed(Routes.register);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    await _authRepository
        .signIn(
          email: email,
          password: password,
        )
        .then(
          (value) async =>
              await navigatorKey.currentState!.popAndPushNamed(Routes.auth),
        );
  }
}
