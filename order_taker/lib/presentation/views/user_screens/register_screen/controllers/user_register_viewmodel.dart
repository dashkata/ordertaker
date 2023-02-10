import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';

import '../../../resources/route_manager.dart';

class UserRegisterViewModel extends StateNotifier<void> {
  UserRegisterViewModel({
    required AuthRepository authRepository,
    required UserRepo userRepo,
  })  : _authRepository = authRepository,
        _userRepo = userRepo,
        super(null);
  final AuthRepository _authRepository;
  final UserRepo _userRepo;

  void navigateToAuth() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.auth);
  }

  void navigateToRestaurantRegister() {
    navigatorKey.currentState!.pushNamed(Routes.restaurantRegister);
  }

  void navigateToLogin() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.login);
  }

  Future<void> register({
    required String email,
    required String password,
    required String mobileNumber,
    required String firstName,
    required String lastName,
  }) async {
    await _authRepository
        .signUp(
          email: email,
          password: password,
        )
        .then(
          (value) => _authRepository.getCurrentUser()!.sendEmailVerification(),
        )
        .then(
          (value) => _userRepo.setMobileNumber(
            _authRepository.getCurrentUser()!.uid,
            mobileNumber,
          ),
        )
        .then(
          (value) => _userRepo.setUserType(
            'Customer',
            _authRepository.getCurrentUser()!.uid,
          ),
        )
        .then(
          (value) => _authRepository.updateUserName(
            name: '$firstName $lastName',
          ),
        )
        .then(
          (value) => navigateToAuth(),
        );
  }
}
