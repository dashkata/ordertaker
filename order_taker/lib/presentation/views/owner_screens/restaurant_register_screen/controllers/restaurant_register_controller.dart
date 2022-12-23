import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';

import '../../../../../data/repositories/auth_repository.dart';
import '../../../resources/route_manager.dart';

class RestaurantRegisterController extends StateNotifier<void> {
  RestaurantRegisterController({
    required AuthRepository authRepository,
    required UserRepo userRepo,
    required RestaurantRepo restaurantRepo,
  })  : _authRepository = authRepository,
        _userRepo = userRepo,
        _restaurantRepo = restaurantRepo,
        super(null);
  final AuthRepository _authRepository;
  final UserRepo _userRepo;
  final RestaurantRepo _restaurantRepo;

  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String restaurantName,
  ) async {
    await _authRepository
        .signUp(email: email, password: password)
        .then(
          (value) => _authRepository.getCurrentUser()!.sendEmailVerification(),
        )
        .then(
          (value) => _restaurantRepo.setRestaurantTitle(
            restaurantName,
            _authRepository.getCurrentUser()!.uid,
          ),
        )
        .then(
          (value) => _userRepo.setMobileNumber(
            _authRepository.getCurrentUser()!.uid,
            phoneNumber,
          ),
        )
        .then(
          (value) => _userRepo.setUserType(
            'Admin',
            _authRepository.getCurrentUser()!.uid,
          ),
        )
        .then(
          (value) => _authRepository.updateUserName(
            name: '$firstName $lastName',
          ),
        )
        .then(
          (value) => _userRepo.setOnBoarding(
            _authRepository.getCurrentUser()!.uid,
            onBoarding: false,
          ),
        );
  }

  void navigateToLogin() {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      Routes.login,
      (Route<dynamic> route) => false,
    );
  }

  void navigateToRegister() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.register);
  }
}
