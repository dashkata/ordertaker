import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repositories/auth_repository.dart';
import '../../../../repositories/firestore_repository.dart';
import '../../../resources/route_manager.dart';

class UserRegisterScreenNotifier extends StateNotifier<void> {
  UserRegisterScreenNotifier({
    required AuthRepository authRepository,
    required FirestoreRepository firestoreRepository,
  })  : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        super(null);
  final AuthRepository _authRepository;
  final FirestoreRepository _firestoreRepository;

  void navigateToAuth() {
    navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }

  void navigateToRestaurantRegister() {
    navigatorKey.currentState!.pushNamed(Routes.restaurantRegister);
  }

  void navigateToLogin() {
    navigatorKey.currentState!.popAndPushNamed(Routes.login);
  }

  Future<void> register(
    String email,
    String password,
    String mobileNumber,
    String firstName,
    String lastName,
  ) async {
    await _authRepository
        .signUp(
          email: email,
          password: password,
        )
        .then(
          (value) => _authRepository.getCurrentUser()!.sendEmailVerification(),
        )
        .then(
          (value) => _firestoreRepository.setMobileNumber(
            _authRepository.getCurrentUser()!.uid,
            mobileNumber,
          ),
        )
        .then(
          (value) => _firestoreRepository.setUserType(
            'Customer',
            _authRepository.getCurrentUser()!.uid,
          ),
        )
        .then(
          (value) => _authRepository.updateUserName(
            name: '$firstName $lastName',
          ),
        );
    navigateToAuth();
  }
}
