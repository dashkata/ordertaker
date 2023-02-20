import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';

class ForgotPasswordViewModel extends StateNotifier<void> {
  ForgotPasswordViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  Future<void> forgotPassword({required String email}) =>
      _authRepository.forgotPassword(
        email: email,
      );
}
