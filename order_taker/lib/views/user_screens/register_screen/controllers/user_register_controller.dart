import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/repositories/auth_repository.dart';
import 'package:order_taker/repositories/firestore_repository.dart';
import 'package:order_taker/views/resources/route_manager.dart';

class UserRegisterScreenNotifier extends StateNotifier<void> {
  UserRegisterScreenNotifier({
    required this.authRepository,
    required this.firestoreRepository,
  }) : super(null);
  final AuthRepository authRepository;
  final FirestoreRepository firestoreRepository;

  void navigateToAuth() {
    navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }

  void navigateToRestaurantRegister() {
    navigatorKey.currentState!.pushNamed(Routes.restaurantRegister);
  }

  void navigateToLogin() {
    navigatorKey.currentState!.pushNamed(Routes.login);
  }

  Future<void> register(
    String email,
    String password,
    String mobileNumber,
    String firstName,
    String lastName,
  ) async {
    await authRepository
        .signUp(
          email: email,
          password: password,
        )
        .then(
            (value) => authRepository.getCurrentUser()!.sendEmailVerification())
        .then((value) => firestoreRepository.setMobileNumber(
            authRepository.getCurrentUser()!.uid, mobileNumber))
        .then((value) => firestoreRepository.setUserType(
            "Customer", authRepository.getCurrentUser()!.uid))
        .then(
          (value) => authRepository.updateUserName(
            name: firstName + " " + lastName,
          ),
        );
    navigateToAuth();
  }
}
